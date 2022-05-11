import 'package:flutter/material.dart';
import 'package:flutter_avanzado2_chat_realtime/src/global/environment.dart';
import 'package:flutter_avanzado2_chat_realtime/src/models/mensajes_response.dart';
import 'package:flutter_avanzado2_chat_realtime/src/models/usuario.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/auth_service.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {

  late Usuario usuarioPara;

Future<List<Mensaje>> getChat(String usuarioID) async{


final resp = await http.get(Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID'),
    headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
      }
    );


final mensajesResp = mensajesResponseFromJson( resp.body );

return mensajesResp.mensajes;






}








}