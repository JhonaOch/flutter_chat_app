// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_avanzado2_chat_realtime/src/pages/login_page.dart';
import 'package:flutter_avanzado2_chat_realtime/src/pages/usuario_page.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/auth_service.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/socket_service.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:checkLoginState(context),
        builder: (context,snapshot){

           return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

             children:const [
                Center(
                  child: Text('Cargando...' , style: TextStyle(fontSize: 20),),
                ),
                SizedBox(
                  height: 20,
                ),
               Center(
                 child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 5, 56, 98)),
                    
                 ),
               ),
             ],
           );



        
            
           


        },
       
      ),
      
    );
  }

  Future checkLoginState( BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService= Provider.of<SocketService>(context,listen:false);
    final autenticado = await authService.isLoggedIn();

    if (autenticado) {

      //TODO conectar socket

      socketService.connect();

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuarioPage(),
          transitionDuration: Duration(milliseconds: 0),
      ));
    } else {

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0),
      ));

    }



  }
}