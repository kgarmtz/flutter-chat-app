import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  // Argumentos que se pueden mandar al widget
  final String text;
  // Con este identificador podremos saber si el mensaje es nuestro o de alguién más
  final String uid;
  // Esta propiedad manejará la animación de los chats
  final AnimationController animationController;

  const ChatMessage({
    Key? key, 
    required this.text, 
    required this.uid,
    required this.animationController,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: this.animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: this.animationController, curve: Curves.easeInOut),
        child: Container(
          // Si fui yo quién envió el mensaje
          child: this.uid == '123'
          ? _myMessage()
          : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage (){
    return Align(
      // Si se trata de mis mensajes estos aparecerán al centro a la derecha
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(
          bottom: 6,
          right: 6,
          // Agregamos un margen a la izquierda para que no se peguen los mensajes
          left: 50
        ),
        child: Text( 
          this.text,
          style: TextStyle( color: Colors.white ),
        ),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }

  Widget _notMyMessage() {    
    return Align(
      // Los mensajes estarán alineados al centro a la izquierda
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(
          bottom: 6,
          left: 6,
          // Agregamos un margen a la derecha para que no se peguen los mensajes que son muy largos
          right: 50
        ),
        child: Text( 
          this.text,
          style: TextStyle( color: Colors.black87 ),
        ),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}