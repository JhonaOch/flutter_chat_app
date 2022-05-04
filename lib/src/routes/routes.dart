import 'package:flutter/cupertino.dart';
import 'package:flutter_avanzado2_chat_realtime/src/pages/chat_page.dart';
import 'package:flutter_avanzado2_chat_realtime/src/pages/loading_page.dart';
import 'package:flutter_avanzado2_chat_realtime/src/pages/login_page.dart';
import 'package:flutter_avanzado2_chat_realtime/src/pages/register_page.dart';
import 'package:flutter_avanzado2_chat_realtime/src/pages/usuario_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios':  (_) => const UsuarioPage(),
  'chat': (_) => const ChatPage(),
  'login': (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'loading': (_) => const LoadingPage(),
};
