
import 'package:flutter/material.dart';
import 'package:flutter_avanzado2_chat_realtime/src/global/environment.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/auth_service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}


class SocketService with ChangeNotifier {

   ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;


 

  void connect() async {

    //TOKEN: https
    final token = await AuthService.getToken();
    
    // Dart client
     //print("object");
   _socket = IO.io(Environment.socketUrl,IO.OptionBuilder()
      .setTransports(['websocket'])
      .enableForceNew()
      .setExtraHeaders(
        {'x-token': token})
       // for Flutter or Dart VM
      //.disableAutoConnect()  // disable auto-connection
       // optional
      .build()
  );
    _socket.connect();

    _socket.onConnect((_) {
    print('connect');
    _serverStatus=ServerStatus.Online;
    notifyListeners();
    
  });

  _socket.onDisconnect((_) {
    print('desconectado');
    _serverStatus=ServerStatus.Offline;
    notifyListeners();
    
  });

    // socket.on('nuevo-mensaje', (data){
    //   print('nuevo-mensaje: $data');
  

    // });
   





  
  }


  void disconnect(){
    print('VOID desconectado');
    _socket.disconnect();
  }

}