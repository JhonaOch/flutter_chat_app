import 'package:flutter/material.dart';
import 'package:flutter_avanzado2_chat_realtime/src/widgets/bottom_widget.dart';
import 'package:flutter_avanzado2_chat_realtime/src/widgets/custum_input_widgets.dart';
import 'package:flutter_avanzado2_chat_realtime/src/widgets/labels_widget.dart';

import '../widgets/logo_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);


     @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height*0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SizedBox(height: 5),
                Logo(
                  image: 'assets/tag-logo.png',
                  title: 'Messenger',
        
                ),
                _FormState(),
                Labels(route: 'register',
                subtitle: '¿No tienes una cuenta?',
                title: 'Crea una cuenta ahora!',),
                Text('Terminos y condiciones de uso',style:TextStyle(fontWeight: FontWeight.w300)),
        
              ],
            ),
          ),
        ),
      )
      
    );
  }
}


class _FormState extends StatefulWidget {
  const _FormState({ Key? key }) : super(key: key);

  @override
  State<_FormState> createState() => __FormStateState();
}

class __FormStateState extends State<_FormState> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email,
            placeholder: 'Correo',
            textcontroller: emailCtrl,
            keyboardType: TextInputType.emailAddress,

          
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textcontroller: passwordCtrl,
            isPassword: true ,

          
          ),

         Bottom(
           title: 'Ingrese', 
           onPressed: (){

           },
           )

          
           //CustomInput(),
        ],
      ),
    );
  }
}


