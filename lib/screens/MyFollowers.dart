import 'package:flutter/material.dart';
import 'package:share/share.dart';


class MyFollowers extends StatefulWidget {
  @override
  _MyFollowersState createState() => _MyFollowersState();
}

class _MyFollowersState extends State<MyFollowers> {
  
   
@override
 void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Column(children:<Widget>[

           Card(
          elevation: 15.0,
          margin: EdgeInsets.only(top: 0),
          child: Container(
            height: 150.0,
            color: Colors.blue.shade900,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                         "My Link",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                     Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Column(
                     children: <Widget>[
                       Text("www.dominioncityg12.com", style:TextStyle(color: Colors.white, fontSize: 11)),
                     ],
                   ),
                  Column(children: <Widget>[
                    IconButton(icon: Icon(Icons.share), color: Colors.white, iconSize: 18,  onPressed: () {
            },)
                    ],),
                    Column(children: <Widget>[
                    IconButton(icon: Icon(Icons.content_copy), color: Colors.white, iconSize: 18,  onPressed: () {
            },)
                    ],)
                    ],
                ),
                  ],
                ),
              
               
                SizedBox(height:20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text("My G12",style: TextStyle(fontSize: 24, color: Colors.white),)
                ],)
              ],
            ),
          ),
        ),
           Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: 12,
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
                          child: 
                          
                          Row(
                            children: <Widget>[
                              Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text("Shadrach Ogombo" , 
                                          style: TextStyle(
                                               fontSize: 20.0,
                                              
                                              fontFamily: 'Monseratti'

                                          ),),
                                        ],
                                      ),
                                      SizedBox(width: 20),

                                    ],
                                    
                                  ),
                                  SizedBox(height:30),
                                  Row(
                                    children:<Widget>[
                                      Column(children:<Widget>[
                                          new IconButton(
                              
                              padding: EdgeInsets.only(left:0),
                              icon: Icon(Icons.phone,color: Colors.red, size: 20,),
                               onPressed: (){}
                              ),
                                      ]),
                                      SizedBox(width:10),
                                   Column(
                                     children: <Widget>[
                                       Text("08031020304 " , 
                                              style: TextStyle(
                                                   fontSize: 14.0,
                                                  color: Colors.grey,
                                                  fontFamily: 'Monseratti'

                                              ),),
                                     ],
                                   ),
                                  ])
                                ],
                              ),
             
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