import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// Local models
import 'package:chat_app/models/models.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  // Elementos necesarios para implementar un Pull to Refresh
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  // Lista de usuarios mapeada de la base de datos
  final usuarios = [
    Usuario( uid: '1', name: 'Kevin',   email: 'kevin_ipn@hotmail.com',   online: true ),
    Usuario( uid: '2', name: 'Luis',    email: 'luis_ipn@hotmail.com',    online: false ),
    Usuario( uid: '3', name: 'Teresa',  email: 'teresa_ipn@hotmail.com',  online: false ),
    Usuario( uid: '4', name: 'Camille', email: 'camille_ipn@hotmail.com', online: true ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: (){},
        ),
        centerTitle: true,
        title: Text('My name', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle_outline, color: Colors.blue[400],)
            // child: Icon(Icons.offline_bolt_outlined, color: Colors.red[400],)
          ),
        ],
      ),
      
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        child: _listViewUsuarios(),
        header: WaterDropHeader(
          complete: Icon(Icons.check_circle_outlined, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400]!,
        ),
        // Comenzamos a cargar los usuarios cuando esta la animación de 'cargar'
        onRefresh: _cargarUsuarios,
      )
    );
  }

  Container _listViewUsuarios() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context , int index) => _usuarioListTile( usuarios[index] ), 
        separatorBuilder: (BuildContext context, int index) => Divider(), 
        itemCount: usuarios.length,
      ),
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      // Icono del principio/delantero
      leading: CircleAvatar(
        child: Text( usuario.name.substring(0,2) ),
        backgroundColor: Colors.blue[100],
      ),
      // Icono del final/trasero
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red[300],
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  _cargarUsuarios() async{

    // Realizamos la petición al endpoint
    await Future.delayed(Duration(milliseconds: 1000));
    // Una vez la petición finalizo, se muestra el icono que especificamos en 'complete'
    _refreshController.refreshCompleted();

  }

}