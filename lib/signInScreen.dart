import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Authservices.dart';
import 'loading_screen.dart';
class SignIn extends StatefulWidget {
   Function toggle=(){};
   SignIn({required this.toggle});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authenticate _auth=Authenticate();
  String password="";
  String email="";
  String error ="";
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Sign In'),
        actions: [
        TextButton.icon(onPressed: (){

           widget.toggle();
        },
            icon: Icon(Icons.person),
            label: Text("Register"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText:'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  hintText:'password',
                  fillColor: Colors.white,
                  filled: true,
                ),
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed:() async{
                    setState(() {
                      loading=true;
                    });
                    dynamic result =await _auth.signIn(email,password);
                    if(result==null){error="invalid credientials please check email or password";
                    setState(() {
                      loading=false;
                    });
                    }
                  } ,

                  child: Text("sign in",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )),
              SizedBox(height: 10,),
              Text(error)
            ],
          ),
        ),
      ),
    );
  }
}