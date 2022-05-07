

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


mostrarAlerta(BuildContext context, String titulo, String subtitle) {  

  if(Platform.isAndroid){

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) =>
       AlertDialog(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(titulo),
        content: Text(subtitle),
        actions: <Widget>[
          MaterialButton(
            child:Text("Ok"),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: ()=>Navigator.pop(context),)

        ],
      )
  );
    
  
}else{
  return showCupertinoDialog(
    context: context,
   // barrierDismissible: true,
    builder: (_) =>
       CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(subtitle),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child:Text("Ok"),
        
            onPressed: ()=>Navigator.pop(context),)

        ],
      
    ),
  );


}

}

      
