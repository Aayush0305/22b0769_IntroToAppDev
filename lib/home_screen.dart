import 'package:flutter/material.dart';
import 'expense_screen.dart';
import 'Category_class.dart';
import 'income_screen.dart';
class Homescrreen extends StatefulWidget {
  List<Ecategory> categorylist=[];
  List<Icategory> icategorylist=[];
   double texp=0;
   double tinc=0;
  @override
  State<Homescrreen> createState() => _HomescrreenState();
}

class _HomescrreenState extends State<Homescrreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        title:  Text(
            'Budget Tracker'
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[800],
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
                  fontSize: 50,
                  wordSpacing: 2,
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
                   SizedBox(width:50 ),
                   Text('Your Total Savings : Rs ${widget.tinc-widget.texp}',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.black,
                     fontSize:20,
                   ),
                   ),
                   SizedBox(width: 50),

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
                                        'Total Expenses: Rs ${widget.texp}',
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
                                      items:widget.categorylist.map((e){
                                        return DropdownMenuItem(child: Text('${e.name}     Rs ${e.amount}'),value: e,);}).toList(),
                                      onChanged: (e){
                                        setState(() {
                                          ExCategory(e!);
                                        });
                                        Navigator.push(context, MaterialPageRoute(builder:(context){return ExCategory(e!);}));
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
                                                widget.categorylist.map((x){setState(() {
                                                  widget.texp=widget.texp+x.amount;});
                                                });
                                                setState(() {
                                                 widget.categorylist.add(newcat);
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
                                      "Total Income: Rs ${widget.tinc}",
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
                                      items:widget.icategorylist.map((e){return DropdownMenuItem(child: Text('${e.name}     Rs ${e.amount}'),value: e,);}).toList(),
                                      onChanged: (e){
                                        setState(() {
                                          Income(e!);
                                        });
                                        Navigator.push(context, MaterialPageRoute(builder:(context){return Income(e!);}));
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
                                                  widget.icategorylist.map((x){setState(() {
                                                   widget.tinc=widget.tinc+x.amount;});
                                                  });

                                                  widget.icategorylist.add(newcat);
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
}

