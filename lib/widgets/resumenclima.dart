

import 'package:flutter/material.dart';

class ResumenClima extends StatelessWidget {
  const ResumenClima({
    super.key,
    required this.size,
    required this.informacion, required this.titulo, required this.icono,
  });

  final Size size;
  final String informacion;
  final String titulo;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.1*size.height,
      width: 0.24*size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icono, color: Colors.white,size: 20, ),
          Text(titulo,style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: -0.8
                ),),
                Text(informacion,style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold
                ),),
        ],
      ),
    );
  }
}
