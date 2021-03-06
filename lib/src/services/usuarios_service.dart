

import 'dart:convert';

import 'package:flutter_avanzado2_chat_realtime/src/global/environment.dart';
import 'package:flutter_avanzado2_chat_realtime/src/models/usuario.dart';
import 'package:flutter_avanzado2_chat_realtime/src/models/usuarios.response.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsuariosService {

  Future<List<Usuario>> getUsuarios() async {

    try {
      
      final resp = await http.get(Uri.parse('${ Environment.apiUrl }/usuarios'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final usuariosResponse = usuariosResponseFromJson( resp.body );

      return usuariosResponse.usuarios;

    } catch (e) {
      return [];
    }

  }


}