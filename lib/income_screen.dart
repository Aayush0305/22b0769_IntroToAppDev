import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/loading_screen.dart';
import 'Category_class.dart';
import 'package:provider/provider.dart';
import 'DatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'loading_screen.dart';
class Incomes{
  String name="";
  double amount=0;
}
class Income extends StatefulWidget {
  Icategory ic;
  List<Icategory> icatl=[];
  Income(this.ic,this.icatl);

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User?>(context);
    final userdata=Provider.of<DocumentSnapshot?>(context);
    Icategory inc=widget.ic;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        title:  Text(
            '${inc.name}'
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[800],
      ),
      body: ListView(
          children:inc.exlist.map((exp){
            int i= inc.exlist.indexOf(exp);
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
                      inc.amount=inc.amount-inc.exlist[i].amount;
                      inc.exlist.removeAt(i);
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
                title: Text('Add your income'),
                content:Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Description of Income',
                        ),
                        onChanged: (value){
                          setState(() {
                            newexp.name=value;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Income(in Rupees)',
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
                          inc.amount= inc.amount +newexp.amount;
                          inc.exlist.add(newexp);

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
