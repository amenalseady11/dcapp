import 'dart:core';
import 'dart:io';


import 'package:dcapp/classes/TestimonyClass.dart' as testimony;
import 'package:dcapp/services/TestimonyServe.dart';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';

class Testimony extends StatefulWidget {
  

  @override
  _Testimony createState() => _Testimony();
}

class _Testimony extends State<Testimony> {


  List<testimony.Testimony> test = List<testimony.Testimony>();
  List<testimony.Testimony> filteredTestimony =
      List<testimony.Testimony>();

  TextEditingController _testimonyController = new TextEditingController();
  String testimonies;
  DateTime dateSubmitted;
  int serverResponse;
   Future<bool> loader(String str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: ScalingText(str),
            ));
  }

  Future<bool> dialog(str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  str,
                  style: TextStyle(fontSize: 14, color: Colors.blue.shade900),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                   onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                  child: Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blue.shade900,
                        color: Colors.blue.shade900,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'Back to List',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontSerrat'),
                          ),
                        )),
                  ),
                ),
              ],
            )));
  }
   Future<bool> checkconnectivity() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }else{
         return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
     new Future.delayed(Duration.zero, () async {
      bool res = await checkconnectivity();
      if (!res) {
        dialog("Internet Required, Check your Network Connection");

        return;
      }
    setState(() {
      
      new Future.delayed(Duration.zero, () {
        loader(' My Testimonies ...');

        TestimonyService.getTestimony(global.profile.member.memberId)
            .then((testimonyRequestFromServer) {
          setState(() {
            test = testimonyRequestFromServer.testimonies;
            
            test.removeWhere((item) => item.testimony == null);

            filteredTestimony = test;

            Navigator.pop(context);
          });
        });
      });
    });
     });
  }

  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MM-dd');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
  }

 

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
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
                      Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40)),
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
                              fontSize: 9,
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
           actions: <Widget>[

            new IconButton(icon: new Icon(Icons.add,color: Colors.blue.shade900,),onPressed: ()async
            {
              bool res = await checkconnectivity();
               if (!res) {
               dialog("Internet Required, Check your Network Connection");
                return;
                   } 
              _displayDialog(context);},),

          ],
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            Card(
              elevation: 15.0,
              margin: EdgeInsets.only(top: 0),
              child: Container(
                padding: EdgeInsets.all(10),
                height: 150.0,
                color: Colors.blue.shade900,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text(
                        ' “I will praise you to all my brothers; I will stand up before the congregation and testify of the wonderful things you have done.”',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Psalm 22:22  (KJV)',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      )
                    ])
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredTestimony.length,
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
                                 Padding(
                                   padding: const EdgeInsets.only(left:18.0),
                                   child: 
                                   Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       
                                       Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                         children: <Widget>[
                                           Row(
                                             children: <Widget>[
                                               Column(
                                                 children: <Widget>[
                                                   Text(filteredTestimony[index].testimony , 
                                                   style: TextStyle(
                                                        fontSize: 12.0,
                                                       
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

                                            Text(getDate(filteredTestimony[index].date).toString() , 
                                                   style: TextStyle(
                                                        fontSize: 14.0,
                                                       color: Colors.grey,
                                                       fontFamily: 'Monseratti'

                                                   ),),
                                           ])
                                         ],
                                       ),
                                      
                                     
                                     ],
                                   ),
                                  
                                 ),
                                 
                                 
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
          ],
        ));
  }


_displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(' Testimony'),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _testimonyController,
                  maxLines: 10,
                  decoration: InputDecoration(
            hintText: "What has the lord done for you?",
            border: OutlineInputBorder(),
        ),
                  onChanged: (String value) {
                        testimonies = value;
                  },
                ),
                
              ],
            ),
            
            actions: <Widget>[
              new RaisedButton(
                color: Colors.blue.shade900,
                child: new Text('Submit'),
                onPressed: () {
                  //save to server
                 new Future.delayed(Duration.zero, () {
                  loader('Submitting Request...');

                 dateSubmitted= DateTime.now();

                    TestimonyService.saveTestimony(global.profile.member.memberId,dateSubmitted,_testimonyController.text,).then((responseFromServer) {
                    setState(() {
                    serverResponse = responseFromServer;
                   if(serverResponse !=null){
                       TestimonyService.getTestimony(global.profile.member.memberId)
            .then((testimonyFromServer) {
          setState(() {
            test = testimonyFromServer.testimonies;
            test.removeWhere((item) => item.testimony == null);

            filteredTestimony = test;
              Navigator.pop(context);
               dialog('Testimony Sent');
          
          });
        });
                   }
                    //Navigator.pop(context);
                 
                    });
                   });
                 });
                }),

                

              new RaisedButton(
                color: Colors.grey,
                child: new Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
              },
            )
         ]
       );
      },
    );
 }










}
