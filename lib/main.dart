import 'package:chat_app/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      // Definimos nuestras rutas
      routes: appRoutes,
      // Esta ruta se encargará de verificar si el usuario esta autenticado o no
      initialRoute: 'login',
      
    );
  }
}