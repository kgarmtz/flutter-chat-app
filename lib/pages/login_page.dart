import 'package:flutter/material.dart';
// Local Widgets
import 'package:chat_app/widgets/widgets.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // Todo el contenido utilizará el 90% de la pantalla del dispositivo
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo( title: 'Messenger' ),
                
                _Form(),
                
                Labels( 
                  route: 'register',
                  title: '¿No tienes cuenta?',
                  subtitle: '¡Crea una ahora!',
                ),
                
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Términos y condiciones de uso', 
                    style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)
                  )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  // Al estar en un StateFulWidget podemos definir los controladores
  final emailController = TextEditingController();
  final passController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      // Añadimos un padding al contenedor para que los inputs se vean bien
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          // Inputs
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passController,
            isPassword: true,
          ),

          // Submit button
          BotonAzul(
            text: 'Ingresar',
            color: Colors.blue,
            onPressed: (){
              print(emailController.text);
              print(passController.text);
            },
          )
          
        ],
      ),
    );
  }
}

