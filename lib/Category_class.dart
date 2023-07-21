import 'package:flutter/material.dart';
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