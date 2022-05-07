import 'package:flutter/material.dart';
import 'package:flutter_avanzado2_chat_realtime/src/helpers/mostrar_alerta.dart';
import 'package:flutter_avanzado2_chat_realtime/src/services/auth_service.dart';
import 'package:flutter_avanzado2_chat_realtime/src/widgets/bottom_widget.dart';
import 'package:flutter_avanzado2_chat_realtime/src/widgets/labels_widget.dart';
import 'package:flutter_avanzado2_chat_realtime/src/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/custum_input_widgets.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                  title: 'Registro',
        
                ),
                _FormState(),
                Labels(route: 'login',
                subtitle: '¿Ya tienes una cuenta?',
                title: 'Ingresa ahora!',),
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
  final nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen:false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        children: [

          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textcontroller: nameCtrl,
            keyboardType: TextInputType.text,

          
          ),
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
           title: 'Registrate', 
           onPressed:authService.autenticando
           ?null
           : () async {
              FocusScope.of(context).unfocus();
              final registroOK= await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passwordCtrl.text.trim());

              print(registroOK);

              if(registroOK == null){
                mostrarAlerta(context, 'Registro incorrecto', 'Rellenar todos los campos');
              }else if(registroOK  == true){
                //   //TODO Conectar socker serve
                Navigator.pushReplacementNamed(context, 'usuarios');


              }else{
                 mostrarAlerta(context, 'Registro incorrecto', registroOK);
              }



            


           },
           )

          
           //CustomInput(),
        ],
      ),
    );
  }
}