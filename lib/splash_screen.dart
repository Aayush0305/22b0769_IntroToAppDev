import 'dart:async';
import 'home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 5), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return Homescrreen();}));});
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.cyan[800],
     body: const Center(
       child : Column(
         children: [
           Expanded(
             flex: 2,
             child: Icon(Icons.attach_money_sharp,
               size: 150,
               color:Colors.green ,
             ),

           ),

           Expanded(
             flex: 2,
             child: Text(
               "Budget Tracker",
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 50,
                 wordSpacing: 2,
                 color: Colors.white,
               ),
             ),

           ),
         ],
       )
      ),
    );
  }
}
