
import 'loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense_screen.dart';
import 'Category_class.dart';
import 'income_screen.dart';
import 'DatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Homescrreen extends StatefulWidget {

  @override
  State<Homescrreen> createState() => _HomescrreenState();
}

class _HomescrreenState extends State<Homescrreen> {
  List<Ecategory> categorylist=[];
  List<Icategory> icategorylist=[];
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User?>(context);
    final  userdata=Provider.of<DocumentSnapshot?>(context);
     var  myeclist=userdata!["Expense"];
    var myiclist=userdata!["Income"];
    for(int i=0;i<myeclist.length;i++){
      var nexc= Ecategory();
      nexc.name=myeclist[i]['name'];
      nexc.amount=myeclist[i]['amount'];
      for(int j=0;j<myeclist[i]["exlist"].length;j++){
        nexc.exlist.add(Expense(name: myeclist[i]["exlist"][j]['name'], amount: myeclist[i]["exlist"][j]['amount']));
      }
      if(categorylist.length<myeclist.length){categorylist.add(nexc);}
    }
    for(int i=0;i<myiclist.length;i++){
      var ninc= Icategory();
      ninc.name=myiclist[i]['name'];
      ninc.amount=myiclist[i]['amount'];
      for(int j=0;j<myiclist[i]["exlist"].length;j++){
        var nexp=Expense(name: myiclist[i]["exlist"][j]['name'], amount: myiclist[i]["exlist"][j]['amount']);
        ninc.exlist.add(nexp);
      }
      if(icategorylist.length<myiclist.length){icategorylist.add(ninc);}

    }
    double texp=0;
    double tinc=0;
    List<Map> iclm=[];
    List<Map> eclm=[];

        void imap(List ic,int l){
          for(int i=0;i <l;i++){
            List<Map> exp=[];
            var icel=ic[i].exlist;
            for(int j=0;j<ic[i].exlist.length;j++){
              exp.add({"name":icel[j].name,"amount":icel[j].amount});
            }
            iclm.add({
              'name':ic[i].name,
              'amount':ic[i].amount,
              'exlist':exp
            });
            tinc=tinc+ic[i].amount;
          }

        }
    void emap(List ec,int l){
      for(int i=0;i <l;i++){
        List<Map> exp=[];
        double amount=0;
        var icel=ec[i].exlist;
        for(int j=0;j<ec[i].exlist.length;j++){
          exp.add({"name":icel[j].name,"amount":icel[j].amount});
          amount=amount+icel[j].amount;
        }
        eclm.add({
          'name':ec[i].name,
          'amount':amount,
          'exlist':exp
        });
        texp=texp+ec[i].amount;
      }

    }
if(userdata.exists){
  return
  Scaffold(
    backgroundColor: Colors.purpleAccent,
    appBar: AppBar(
      title:  Text(
          'Budget Tracker'
      ),
      centerTitle: true,
      backgroundColor: Colors.purple[800],
      actions: [
        TextButton.icon(onPressed: (){
          FirebaseAuth.instance.signOut();
        },
            icon: Icon(Icons.person),
            label: Text("Sign Out"))
      ],
    ),
    body: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(3),
              child: Image(
                image: AssetImage('images/username-icon-27.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            flex: 2,
            child: Container(
              padding:EdgeInsets.all(1),
              child: Text('WELCOME  BACK!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    wordSpacing: 1,
                    color: Colors.black
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(0.6),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Row(
                children: [
                  SizedBox(width:2 ),
                  Text('Your Total Savings : Rs ${userdata!["totalIncome"]-userdata!["totalExpense"]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize:20,
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
              flex: 4,
              child:Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Card(
                      margin: EdgeInsets.all(5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Total Expenses: Rs ${userdata!["totalExpense"]}',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 1,
                            child: DropdownButton(
                                items:categorylist.map((e){
                                  return DropdownMenuItem(child: Text('${e.name}     Rs ${e.amount}'),value: e,);}).toList(),
                                onTap: (){
                                  var cl=categorylist;
                                  var l=categorylist.length;
                                  try{
                                    emap(cl,l);
                                  }catch(e){print("my error  ${e.toString()}");}
                                  DatabaseServices(uid:user!.uid).updateEData(eclm,texp);
                                },
                                onChanged: (e){
                                  try{ Navigator.push(context, MaterialPageRoute(builder:(context){return ExCategory(e!);}));}
                                  catch(e){print("error is:${e.toString()}");}
                                }
                            ),
                          ),
                          SizedBox(height: 30,),
                          Expanded(
                            flex: 2,
                            child: FloatingActionButton(
                              onPressed: (){
                                var newcat= new  Ecategory();
                                showDialog(context: context, builder:
                                    (context){
                                  return Container(
                                    child: AlertDialog(
                                      title: Text('Add new Category of Expense'),
                                      content:Column(
                                          children: [
                                            TextField(
                                              decoration: InputDecoration(
                                                hintText: ' Expense Category name',
                                              ),
                                              onChanged: (value){
                                                setState(() {
                                                  newcat.name=value;
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
                                                categorylist.add(newcat);
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      margin: EdgeInsets.all(5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Total Income: Rs ${userdata!["totalIncome"]}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: DropdownButton(
                                items:icategorylist.map((e){return DropdownMenuItem(child: Text('${e.name}     Rs ${e.amount}'),value: e,);}).toList(),
                                onTap: (){
                                  var ic=icategorylist;
                                   int l=ic.length;
                                     imap(ic,l);
                                  DatabaseServices(uid:user!.uid).updateIData(iclm,tinc);
                                  setState(() {
                                  });
                                },
                                onChanged: (e){
                                  Navigator.push(context, MaterialPageRoute(builder:(context){return Income(e!,icategorylist);}));
                                }
                            ),
                          ),SizedBox(height: 30,),
                          Expanded(
                            flex: 2,
                            child: FloatingActionButton(
                              onPressed: (){
                                var newcat= new  Icategory();
                                showDialog(context: context, builder:
                                    (context){
                                  return Container(
                                    child: AlertDialog(
                                      title: Text('Add new Category of Income'),
                                      content:Column(
                                          children: [
                                            TextField(
                                              decoration: InputDecoration(
                                                hintText: ' Income Category name',
                                              ),
                                              onChanged: (value){
                                                setState(() {
                                                  newcat.name=value;
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
                                                icategorylist.add(newcat);
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
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
          )
        ],
      ),
    ) ,


  );
}
else{
  return Loading();}
  }
}

