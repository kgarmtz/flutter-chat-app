import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  // Argumentos
  final String route;
  final String title;
  final String subtitle;
  final Color color;

  const Labels({
    Key? key, 
    required this.route,
    required this.title,
    required this.subtitle,
    // Argumentos opcionales
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          this.title,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
        
        SizedBox(height: 10),

        GestureDetector(
          child: Text(
            this.subtitle,
            style: TextStyle(
              color: this.color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          onTap: (){
            // Elimina la página anterior para que no sea posible regresar a ella
            Navigator.pushReplacementNamed(context, this.route);
          },
        ),
      ]
    );
  }
}