import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  // Definimos los argumentos que va a recibir nuestro widget
  final void Function()? onPressed;
  final String text;
  final Color color;

  const BotonAzul({ 
    Key? key, 
    required this.onPressed,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed, 
      
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        elevation: 3,
        shape: StadiumBorder(),
        backgroundColor: this.onPressed == null ? Colors.grey : this.color,
      ),

      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(this.text, style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}