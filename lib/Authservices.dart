
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DatabaseServices.dart';
class Authenticate{
final FirebaseAuth _auth=FirebaseAuth.instance;

Future register(String email,String password) async{
  try {
  UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
  User? user =result.user;
 await DatabaseServices(uid:user!.uid).updateData([],[],0,0);

  return result.user;
  }
  catch(e){
 print(e.toString());
  }
}
Future signIn(String email,String password) async{
  try {
    UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }
  catch(e){
    print(e.toString());
  }
}
Stream<User?> get user{
  return _auth.authStateChanges();
}
}
