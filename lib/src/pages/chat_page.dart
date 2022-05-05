

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avanzado2_chat_realtime/src/widgets/chat_message_widget.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo=false;
  List<ChatMessage> _messages =[
    // ChatMessage(uid:'123' ,texto: 'Hola mundo'),
    //  ChatMessage(uid:'123' ,texto: 'Hola mundo'),
    //   ChatMessage(uid:'123' ,texto: 'Hola mundo'),
    //   ChatMessage(uid:'123222' ,texto: 'Hola mundo'),
    //   ChatMessage(uid:'123222' ,texto: 'Hola mundo')

  ];




 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation:1,
        centerTitle: true,
        title: Column(children: [
          CircleAvatar(
            child: Text('J',style:TextStyle(fontSize:12) ,),
            backgroundColor: Colors.blue[100], 
            maxRadius: 14,
          ),
          SizedBox(
            height: 3,
          ),
          Text('Juan Flores',style:TextStyle(fontSize:12,color: Colors.black54),),
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
    final newMessage =  ChatMessage(uid:'123' ,texto: text,animationController: AnimationController(vsync: this,duration: Duration(milliseconds: 200)),);
    _messages.insert(0,newMessage);
    newMessage.animationController.forward();


    setState(() {
      _estaEscribiendo=false;
    });
  

  }

  @override
  void dispose() {
    // TODO: Off del socket
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }

}