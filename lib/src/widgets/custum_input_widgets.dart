

import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
   final IconData icon;
  final String placeholder;
  final TextEditingController textcontroller;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({ 
    Key? key, 
    required this.icon,
     required this.placeholder,
      required this.textcontroller,
       this.keyboardType = TextInputType.text, 
        this.isPassword=false }) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            padding:const EdgeInsets.only(top:5,left: 5,right: 20,bottom: 5),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: textcontroller,
              autocorrect: false,
              keyboardType: keyboardType,
              obscureText: isPassword,
              decoration: InputDecoration(
                prefixIcon:  Icon(icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: placeholder,
                
              ),
            
            )
            
          

            
          ),
        ],
      ),
    );
  }
}