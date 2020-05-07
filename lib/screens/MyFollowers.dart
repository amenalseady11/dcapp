import 'package:dcapp/services/FollowerServ.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/classes/FollowersClass.dart' as followers;
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class MyFollowers extends StatefulWidget {
  @override
  _MyFollowersState createState() => _MyFollowersState();
}

class _MyFollowersState extends State<MyFollowers> {
  List<followers.Myfollower> _follow = new List<followers.Myfollower>();
 List<followers.Myfollower> filteredFollowers = new List<followers.Myfollower>();
  
  Future<bool> loader(String str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: ScalingText(str),
            ));
  }

   
@override
 void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
        new Future.delayed(Duration.zero, () {
        loader('My Followers ...');

        GetMyFollowerService.getFollower(global.profile.member.memberId).then((followerFromServer) {
          
          setState(() {
            _follow = followerFromServer.myfollowers;
            _follow.removeWhere((item) => item.firstName == null);
            _follow.removeWhere((item) => item.lastName == null);
            _follow.removeWhere((item) => item.phone == null);
            filteredFollowers = _follow;
            

            Navigator.pop(context);
          });
        });
      });
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
                          '...raising leaders that transform society',
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
                    IconButton(icon: Icon(Icons.share), color: Colors.white, iconSize: 18, tooltip: "Share",
                     onPressed: () {
                       Share.share("Click this link below to join my G12 group \n\n"+"www.dominioncityg12.com/parentId="+global.profile.member.memberId.toString()+ "\n\n For with the heart man believeth unto righteousness; and with the mouth confession is made unto salvation. 11For the scripture saith, Whosoever believeth on him shall not be ashamed. For there is no difference between the Jew and the Greek: for the same Lord over all is rich unto all that call upon him.For whosoever shall call upon the name of the Lord shall be saved. \nRomans 5: 12-14");
                     },)
                    ],),
                    GestureDetector(
                      child: Column(children: <Widget>[
                      IconButton(icon: Icon(Icons.content_copy), color: Colors.white, iconSize: 18, tooltip: "Copied",  onPressed: () {
                      Clipboard.setData(new ClipboardData(text: "Click this link below to join my G12 group \n\n"+"www.dominioncityg12.com/parentId="+global.profile.member.memberId.toString()+ "\n\n For with the heart man believeth unto righteousness; and with the mouth confession is made unto salvation. 11For the scripture saith, Whosoever believeth on him shall not be ashamed. For there is no difference between the Jew and the Greek: for the same Lord over all is rich unto all that call upon him.For whosoever shall call upon the name of the Lord shall be saved. \nRomans 5: 12-14"));

                               },)
                      ],),
                    )
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
                  itemCount: filteredFollowers.length,
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
                                          Text(filteredFollowers[index].firstName + " " + filteredFollowers[index].lastName , 
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
                              icon: Icon(Icons.phone,color: Colors.green, size: 25,),
                              onPressed: ()=> launch("tel:${filteredFollowers[index].phone.toString()}"),
                              ),
                                      ]),
                                      SizedBox(width:10),
                                   Column(
                                     children: <Widget>[
                                       Text(filteredFollowers[index].phone , 
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