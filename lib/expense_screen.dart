import 'package:flutter/material.dart';
import 'Category_class.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'DatabaseServices.dart';
class ExCategory extends StatefulWidget {
  Ecategory ct;
  ExCategory(this.ct);

  @override
  State<ExCategory> createState() => _ExCategoryState();
}

class _ExCategoryState extends State<ExCategory> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User?>(context);
    final userdata=Provider.of<DocumentSnapshot?>(context);
    var c=widget.ct;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        title:  Text(
            '${c.name}'
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[800],
      ),
     body: ListView(
       children:c.exlist.map((exp){
         int i= c.exlist.indexOf(exp);
         return Container(
           padding: EdgeInsets.all(20),
           margin: EdgeInsets.all(15),
           decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(30))
           ),
           child: ListTile(
             title: Text('${exp.name}                     Rs  ${exp.amount}'),
             trailing: IconButton(
               icon: Icon(Icons.delete),
               onPressed: (){
                setState(() {
                  c.amount=c.amount-c.exlist[i].amount;
                  c.exlist.removeAt(i);
                 // DatabaseServices(uid:user!.uid).updateEData(widget.ecatl);
                });
               },
             ),
             onTap: (){},
           ),
         );
       }).toList()
     ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          var newexp= new  Expense(name :'',amount: 0);
          showDialog(context: context, builder:
              (context){
            return Container(
              child: AlertDialog(
                title: Text('Add your expense'),
                content:Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Description of expense',
                        ),
                        onChanged: (value){
                          setState(() {
                            newexp.name=value;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Amount(in Rupees)',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          double v= double.parse(value);
                          setState(() {
                            newexp.amount=v;
                          });
                        },
                      ),
                    ]
                ),
                actions: [
                  ElevatedButton(
                      child: Text('Add'),
                      onPressed: () {
                        setState(() {
                          c.amount= c.amount +newexp.amount;
                          c.exlist.add(newexp);
                         // DatabaseServices(uid:user!.uid).updateEData(widget.ecatl);
                        });
                        Navigator.pop(context);
                      } ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text('close')
                  )
                ],
              ),
            );
          }
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),

      );
  }
}
