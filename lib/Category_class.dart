import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Expense{
  String name='';
  double amount=0;
  Expense({required this.name,required this.amount});
}
class Ecategory{
  String name='';
  double amount=0;
  List<Expense> exlist=[];
}
class Icategory{
  String name='';
  double amount=0;
  List<Expense> exlist=[];
}
