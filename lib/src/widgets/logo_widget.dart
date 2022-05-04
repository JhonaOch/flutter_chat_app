import 'package:flutter/material.dart';


class Logo extends StatelessWidget {

  final String image;
  final String title;
  final double tamTitle;
  const Logo({Key? key,
   required this.image, 
  required this.title,  this.tamTitle=30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // ignore: sized_box_for_whitespace
      child: Container(
        width: 170,
        
        child:Column(
          children:[
            Image.asset(image),
            const SizedBox(height: 20,),
            Text(title,style: TextStyle(fontSize: tamTitle),),
            
        
          
          ]
        ),
      
      ),
    );
  }
}
