

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avanzado2_chat_realtime/src/models/mensajes_response.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/auth_service.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/chat_service.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/socket_service.dart';
import 'package:flutter_avanzado2_chat_realtime/src/widgets/chat_message_widget.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;
  bool _estaEscribiendo=false;
  final List<ChatMessage> _messages =[];

@override
  void initState() {
    chatService = Provider.of<ChatService>(context,listen: false);
    socketService = Provider.of<SocketService>(context,listen: false);
    authService = Provider.of<AuthService>(context,listen: false);

    socketService.socket.on('mensaje-personal', _escuharMensaje);


    _cargarHistorial(chatService.usuarioPara.uid);

    super.initState();
  }

  void _escuharMensaje(dynamic payload) {
    ChatMessage message = ChatMessage(
      texto:payload['mensaje'] ,
      uid:payload['de'],
      animationController: AnimationController(
        vsync: this,
        duration:const Duration(milliseconds: 300),
    ));

    setState(() {


      _messages.insert(0, message);

    });

    message.animationController.forward();
  }

void _cargarHistorial(String? uid) async {
  List<Mensaje> chat = await chatService.getChat(uid!);

  final history = await chat.map((m) => ChatMessage(

    texto:m.mensaje as String,
    uid:m.de as String,
    animationController: AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 0),
    )..forward(),
  ));

  setState(() {
    _messages.insertAll(0,history);
  });





}

 @override
  Widget build(BuildContext context) {
   
    final usuarioPara =chatService.usuarioPara;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation:1,
        centerTitle: true,
        title: Column(children: [
          CircleAvatar(
            child: Text(usuarioPara.nombre!.substring(0,2),style:TextStyle(fontSize:12) ,),
            backgroundColor: Colors.blue[100], 
            maxRadius: 14,
          ),
          SizedBox(
            height: 3,
          ),
          Text(usuarioPara.nombre as String,style:TextStyle(fontSize:12,color: Colors.black54),),
        ]),
      ),

      body: Container(
        child:Column(
          children: [
            Flexible(child: 
            ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder:(_,i)=>_messages[i] ,
              reverse: true,
            )
            ),
            Divider(
              height: 1,
            ),
              //TODO Caja de texto
            Container(
              color: Colors.white,
             
              child:_inputChat()
            )

          ]
        )
      )
      
    );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child:Row(
          children: [
            Flexible(
              child: TextField(
                controller:_textController ,
                onSubmitted:  _handleSubmit,
                onChanged: (String texto){
                  setState(() {
                    if(texto.trim().length>0){
                       _estaEscribiendo=true;
                    }else{
                      _estaEscribiendo=false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar un mensaje',
                ),
                focusNode:_focusNode ,
              ),
              ),
              //BOTON DE ENVIAR DE
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
              ? CupertinoButton(child: Text("Enviar"),
              onPressed: _estaEscribiendo
                    ? ()=>_handleSubmit(_textController.text.trim())
                    : null,)



              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send),
                    onPressed: _estaEscribiendo
                    ? ()=>_handleSubmit(_textController.text.trim())
                    : null,
                  ),
                )


              )
            )
          ]
        )
      ));


  }

  _handleSubmit(String text){
    print(text);

    if(text.length==0) return;
      _textController.clear();
    _focusNode.requestFocus();
    final newMessage =  ChatMessage(uid:authService.usuario.uid as String,texto: text,animationController: AnimationController(vsync: this,duration: const Duration(milliseconds: 200)),);
    _messages.insert(0,newMessage);
    newMessage.animationController.forward();


    setState(() {
      _estaEscribiendo=false;
    });

    socketService.emit('mensaje-personal',{
      'de':authService.usuario.uid,
      'para':chatService.usuarioPara.uid,
      'mensaje':text

    });
  

  }

  @override
  void dispose() {
    // TODO: Off del socket
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }

}