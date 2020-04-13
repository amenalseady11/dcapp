import 'package:flutter/material.dart';
class G12Academy extends StatefulWidget {
  @override
  _G12AcademyState createState() => _G12AcademyState();
}

class _G12AcademyState extends State<G12Academy> {

final List<String> list = [ "STEP ONE — ACKNOWLEDGE","STEP TWO — REPENT","STEP THREE — CONFESS", "STEP FOUR — FORSAKE","STEP FIVE — BELIEVE","STEP SIX — RECEIVE", 
   ];
 List<String> filteredlist = List();
  @override
  void initState() {
    super.initState();
    setState(() {

      filteredlist = list;
      
     
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
        iconTheme: new IconThemeData(color: Colors.blue.shade900),
        elevation: 15.0,
        title: Column(children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Image(
                          image: AssetImage("assets/domcitylogo2.jpg"),
                          width: 50,
                          height: 50),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 80),
                        child: new Text(
                          'Dominion City',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        child: new Text(
                          '...raising leaders that transforms society',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
        
        backgroundColor: Colors.white,
        actions: <Widget>[
        ],
      ),
body: Column(
  children:<Widget>[
              Card(
          elevation: 15.0,
          margin: EdgeInsets.only(top: 0),
          child: Container(
            height: 150.0,
            color: Colors.blue.shade900,
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:<Widget>[
                 Column(children: <Widget>[
                   Text("Your Mentor :", style: TextStyle(color:Colors.white),)
                 ],),
                 SizedBox(width:5),
                  Column(children: <Widget>[
                     Text("Obi Azubike", style: TextStyle(fontSize: 20, color: Colors.white),)
                 ],),
               ]),
               SizedBox(height:5),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:<Widget>[
                 Column(children: <Widget>[
                   Text("Number of Mentees :", style: TextStyle(color:Colors.white),)
                 ],),
                 SizedBox(height:5),
                  Column(children: <Widget>[
                     Text("10", style: TextStyle(fontSize: 20, color: Colors.white),)
                 ],),
               ]),
               SizedBox(height:20),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:<Widget>[
                 Text("G12 Academy", style:TextStyle(color: Colors.white, fontSize:24))
               ])
              ]
            )
          ),
        ),
       Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: (){
                        setState(() {
                          
                        });
                      },

                     child:  Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(filteredlist[index].toString(), style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti'

                            ),),

                          ],
                        ),
                      ),
                    )
                      ,
                    );

                  }),
            )
]),
       bottomNavigationBar: BottomAppBar(
      child: Container(
      
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           FlatButton(
                        color: Colors.blue,
                        child: Row(
                          children: <Widget>[
                            Text("Join Meeting", style: TextStyle(color:Colors.white),),
                          ],
                        ),
                        onPressed: (){},
                      ),
                      SizedBox(width:10),
                FlatButton(
                        color: Colors.blue,
                        child: Row(
                          children: <Widget>[
                            Text("Chat Room", style: TextStyle(color:Colors.white),),
                          ],
                        ),
                        onPressed: (){},
                      ),
          ],
        ),
      ),
    ),
    );
  }
}