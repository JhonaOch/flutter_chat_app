
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_avanzado2_chat_realtime/src/models/usuario.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/auth_service.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/chat_service.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/socket_service.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/usuarios_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuarioPage extends StatefulWidget {
  const UsuarioPage({ Key? key }) : super(key: key);

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  // ignore: unused_field
  final RefreshController _refreshController= RefreshController(initialRefresh: false);
  final usuarioService = UsuariosService();


  List<Usuario> usuarios =[];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService =Provider.of<SocketService>(context);
    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

     title:  Text(usuario.nombre as String,style:  TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading:  IconButton(
          onPressed: (){
            //TODO Desconectarnos del socket service

            socketService.disconnect();
            
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();

          }, icon: Icon(Icons.exit_to_app,color: Colors.black54),
          ),
        // ignore: prefer_const_literals_to_create_immutables
        actions:  [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? const Icon(Icons.check_circle, color: Colors.blue)
                  : const Icon(
                      Icons.offline_bolt,
                      color: Color.fromARGB(255, 255, 17, 0),
                    )),
        ],
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
        onTap: (){
          final chatService = Provider.of<ChatService>(context,listen:false);
          chatService.usuarioPara = usuario;
          Navigator.pushNamed(context, 'chat');


        }
      );
  }

  _cargarUsuarios() async{

    

    usuarios= await usuarioService.getUsuarios();

  

    setState(() {
      
    });
    // await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();

  }
}
