import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Category_class.dart';

class DatabaseServices{
   String uid="";
  DatabaseServices({required this.uid});
  final CollectionReference budgetDataCollection= FirebaseFirestore.instance.collection("BudgetData");

    Future updateIData(List<Map> ic,double tincome) async {
      return await budgetDataCollection.doc(uid).update({
        "Income": ic,
        "totalIncome":tincome,
      });

}
   Future updateEData(List<Map> ec,double texpense) async {
     return  budgetDataCollection.doc(uid).update({
       "Expense": ec,
       "totalExpense": texpense,
     });
   }
   Future updateData(List<Map> ic,List<Map>  ec,double texpense,double tincome)async{
     return await budgetDataCollection.doc(uid).set({
       "Income": ic,
       "Expense": ec,
       "totalExpense": texpense,
       "totalIncome":tincome,
     });
   }
Stream<DocumentSnapshot> get userData{
    return  budgetDataCollection.doc(uid).snapshots();
}
}