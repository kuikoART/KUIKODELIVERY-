
import 'package:flutter/material.dart';
import '../models/negocio.dart';

class NegocioCard extends StatelessWidget {
  final Negocio negocio;
  NegocioCard({required this.negocio});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(negocio.nombre),
        subtitle: Text('${negocio.categoria} – ${negocio.descripcion}'),
      ),
    );
  }
}
