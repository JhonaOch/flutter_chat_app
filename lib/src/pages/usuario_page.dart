
import 'package:flutter/material.dart';
import 'package:flutter_avanzado2_chat_realtime/src/models/usuario.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuarioPage extends StatefulWidget {
  const UsuarioPage({ Key? key }) : super(key: key);

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  // ignore: unused_field
  final RefreshController _refreshController= RefreshController(initialRefresh: false);
  final usuarios =[
  Usuario(uid: '1', nombre: 'Maria', email: 'test@1.com',online: true),
  Usuario(uid: '2', nombre: 'Juan', email: 'test@2.com',online: true),
  Usuario(uid: '3', nombre: 'Pepe', email: 'test@3.com',online: true),
  Usuario(uid: '4', nombre: 'Camilo', email: 'test@4.com',online: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

     title:  Text('Mi nombre' ,style:  TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: const IconButton(
          onPressed: null, icon: Icon(Icons.exit_to_app,color: Colors.black54),
          ),
        actions: <Widget>[
          const IconButton(
            onPressed: null, icon: Icon(Icons.check_circle,color: Color.fromARGB(255, 21, 0, 255)),)
        ]
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check,color:Colors.blue[400]),
          waterDropColor: Colors.blue,
        ),
        child: listViewUsuarios(),)
      
    );
  }

  ListView listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_,i)=>_usuarioListile(usuarios[i]), 
      separatorBuilder: (_,i)=>Divider(),
       itemCount: usuarios.length);
  }

  ListTile _usuarioListile(Usuario usuario) {
    return ListTile(
        title:Text(usuario.nombre as String),
        subtitle: Text(usuario.email as String),
        leading: CircleAvatar(
          child: Text(usuario.nombre!.substring(0,2)),
          backgroundColor: Colors.blue[100],
          
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)
          )
        ),
      );
  }

  _cargarUsuarios() async{
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();

  }
}
