// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String title;
  final String subtitle;
  const Labels({Key? key, 
  required this.route, required this.title, 
  required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(children:  [
      
         SizedBox(
          height: 20,
        ),
     
         Text(subtitle),
     
         SizedBox(
          height: 20,
        ),
         GestureDetector(
           child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        onTap: () {
          Navigator.pushReplacementNamed(context, route);
        }
         ),
      ]),
    );
  }
}
