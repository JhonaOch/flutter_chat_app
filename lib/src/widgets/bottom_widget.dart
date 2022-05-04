import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  final String title ;
  final void Function() onPressed;
  final Color color;
  const Bottom({ Key? key, 
  required this.title, 
  required this.onPressed, 
  this.color=Colors.blue }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(

            onPressed: onPressed,


            // ignore: prefer_const_constructors
            style:   ElevatedButton.styleFrom(
              elevation: 5,

              //highlightElevation: 8,
              shape: const StadiumBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 2
              )),
              primary: color

             ),
            
              

              
             
            

            child: Container( 
              
              width: MediaQuery.of(context).size.width/1.6,
              height: 55,
              child:Center(child: 
              Text(title,
              style:TextStyle(color:Colors.white,fontSize: 18)),)
            ),

                       
            

          );
  }
}