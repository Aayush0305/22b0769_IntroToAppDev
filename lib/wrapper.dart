
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/home_screen.dart';
import 'signInandRegister.dart';
import 'package:provider/provider.dart';
import 'DatabaseServices.dart';
class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User?>(context);
  if(user!=null){return StreamProvider.value(
      initialData:  null,
      value: DatabaseServices(uid: user.uid).userData,
      child: Homescrreen());}
else{return Authenticate();}
  }
}
