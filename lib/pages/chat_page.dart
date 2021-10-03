import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
// Local widgets
import 'package:chat_app/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _isTyping = false;
  // Creamos una colección de ChatMessages
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('Ke', style: TextStyle(fontSize: 12, color: Colors.blue[800], fontWeight: FontWeight.bold)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),

            SizedBox(height: 3),

            Text('Kevin García', style: TextStyle(color: Colors.black87, fontSize: 12)),
          ],
        ),
      ),

      body: Container(
        child: Column(
          children: [
            // Flexible widget gives to a Column the flexibility to expand to fill the available space in the main axis
            Flexible(
              // El child será la lista de todos los mensajes que tendrá
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => _messages[index],
                itemCount: _messages.length,
                // Para hacer scroll hacia arriba
                reverse: true,
              )
            ),

            Divider(height: 1),

            Container(
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            // La caja de texto debe ocupar todo el ancho posible a los lados (main axis)
            Flexible(
              child: TextField(
                // El controller nos permitirá saber que valor tiene la caja de texto en todo momento
                controller: _textController,
                onSubmitted: _handleSubmit,
                // Con el método onChange podemos saber que el usuario  esta escribiendo
                onChanged: (String text){

                  setState(() {
                    if (text.trim().length > 0){
                      _isTyping = true;
                    } else {
                      _isTyping = false;
                    }
                  });

                },
                // Este tipo de input no incluye un borde por defecto
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),

                // Cuando se envie el mensaje, necesitamos volver a enfocar el TextField para que 
                // el teclado siga abierto, la caja de texto se siga mostrando
                focusNode: _focusNode,
              ),
            ),

            // Botón para enviar el mensaje
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Platform.isIOS
              ? CupertinoButton(
                child: Text('Enviar'), 
                onPressed: (){}
              )
              : Container(
                child: IconTheme(
                  // El color del botón será azul si lo que se manda en la función "onpressed"
                  // es distinto de null, si se manda null entonces será de color gris simulando
                  // que el botón de encuentra inhabilitado
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    // Si el usuario esta escribiendo, entonces se habilita el botón
                    onPressed: _isTyping
                    ? () => _handleSubmit( _textController.text.trim() )
                    : null,
                    // Quitamos los efectos de Material, de modo que no aparece un fondo al presionar el boton
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    // Si mandan texto vacio entonces no hace nada
    if( text.length == 0 ) return;

    print(text);
     // Cuando el usuario envie el mensaje limpiamos la caja de texto
    _textController.clear();
    // Para que la caja de texto se quede abierta una vez se ha enviado el mensaje
    _focusNode.requestFocus();

    // Creamos una nueva instancia de un mensaje
    final newMessage = new ChatMessage(
      text: text, 
      uid: '123',
      // Creamos una animación para cada mensaje
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );

    // Añadimos el nuevo mensaje al inicio del arreglo
    // de modo que cualquier mensaje enviado aparecerá
    // siempre al principio.
    _messages.insert(0, newMessage);
    // Iniciamos la animación del mensaje una vez se inserto en el arreglo
    newMessage.animationController.forward();
  
    // Una vez que el mensaje se envio, reiniciamos la variable
    setState(() {
      _isTyping = false;
    });
  }
  
  // Este método se ejecuta cuando cerremos la pantalla del chat
  @override
  void dispose() {
    // Limpiamos los controladores de la animación en cada uno de los mensajes del arreglo _messages
    for( ChatMessage message in _messages ){
      message.animationController.dispose();
    }

    super.dispose();
  }
}