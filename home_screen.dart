
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../data/negocios_local.dart';
import '../services/location_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    LocationService().getCurrentLocation().then((pos) {
      if (pos != null) {
        setState(() {
          currentLocation = LatLng(pos.latitude, pos.longitude);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('KuikoDelivery Santiago')),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: currentLocation,
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80,
                      height: 80,
                      point: currentLocation!,
                      builder: (ctx) =>
                          Icon(Icons.my_location, color: Colors.blue),
                    ),
                    ...negocios.map((n) => Marker(
                          width: 80,
                          height: 80,
                          point: LatLng(n.lat, n.lng),
                          builder: (ctx) =>
                              Icon(Icons.store, color: Colors.red),
                        )),
                  ],
                ),
              ],
            ),
    );
  }
}
