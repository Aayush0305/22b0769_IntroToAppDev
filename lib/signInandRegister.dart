import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Authservices.dart';
import 'signInScreen.dart';
import 'registerScreen.dart';
class Authenticate extends StatefulWidget {

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;

  void toggle(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
   if(showSignIn){return SignIn(toggle: toggle,);}
   else{
     return Register(toggle: toggle,);
   }
  }
}
