import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  // Definimos los argumentos que podrá recibir
  final IconData icon;
  final String placeholder;
  // Esta propiedad nos servirá para obtener el texto que se haya ingresado en el Input
  final TextEditingController textController;
  final TextInputType keyboardType;
  final Color color;
  final bool isPassword;

  const CustomInput({
    Key? key, 
    required this.icon, 
    required this.placeholder, 
    required this.textController, 
    // Argumentos opcionales
    this.keyboardType = TextInputType.text, 
    this.color = Colors.blue,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Añadimos un margin para crear una separación si ocupamos varios CustomInputs
      margin: EdgeInsets.only(bottom: 20),
      // Este padding será aplicado directamente al TextField
      padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ]
      ),
     
      child: TextField(
        autocorrect: false,
        keyboardType: this.keyboardType,
        controller: this.textController,
        obscureText: this.isPassword,
        cursorColor: this.color,
        decoration: InputDecoration(
          // Icono al principio del input
          prefixIcon: Icon(this.icon, color: this.color),
          // Eliminamos la línea que aparece debajo del input cuando esta seleccionado
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder,
        ),
      ),
    );
  }
}