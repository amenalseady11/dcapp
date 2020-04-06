import 'dart:core';
import 'package:dcapp/classes/MvpClass.dart' as mv ;
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/services/MVPServe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:progress_indicators/progress_indicators.dart';


class MVP extends StatefulWidget{
 // final int subId;
 
  @override
  _MVP createState() => _MVP();

}
class _MVP extends State<MVP>{
mv.MvpClass mvpclass = new mv.MvpClass();
List<mv.MvP> mvp = new List<mv.MvP>();
List<mv.MvP> filteredMvp = new List<mv.MvP>();

  @override
  void initState() {
    super.initState();
    setState(() {


    
      new Future.delayed(Duration.zero, () {
                  loader('Loading MVP List...');

     MVPService.getMvp(global.profile.member.branch.branchId).then((mvpFromServer) {
        setState(() {
         mvpclass = mvpFromServer;
         mvp = mvpclass.mvPs;
          mvp.removeWhere((item)=>item.branch== null);
          mvp.removeWhere((item)=>item.dateJoined== null);
          mvp.removeWhere((item)=>item.zone== null);
          
          mvp.sort((a, b) => a.memberSince.compareTo(b.memberSince));

          filteredMvp = mvp;

         Navigator.pop(context);
        });
      });
      });

   });
  }
   
   String getDate(DateTime date){
     
     
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(date);
      return formateddateposted.toString();


   }
  Future<bool> loader(String str){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText(str),
        ));
  }

  Future<bool> dialog(str){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title:Text('Message') ,
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(str, style: TextStyle(
          fontSize: 14,
          color: Colors.blue.shade900

        ),),
        SizedBox(height: 10.0,),
        Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blue.shade900,
                        color: Colors.blue.shade900,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){
                             Navigator.pop(context);
                             Navigator.pop(context);
                             
                          },
                          child: Center(
                            child: Text(
                              'Back to List',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                          ),
                        )
                    ),

                  ),
        ],) 
        
      ));
    }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
          appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.blue.shade900),
        elevation: 15.0,

        title:Column(children:<Widget>[
             Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 2)),
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
                              fontSize: 10,
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
        ]
        ),
        backgroundColor: Colors.white,
),
        body:
        Column(
          children: <Widget>[
           Card(
              elevation: 15.0,
              margin: EdgeInsets.only(top:0),
              child: Container(
                height: 150.0,
                color: Colors.blue.shade900,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text('Number of MVPs', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredMvp.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                    ],),
                    SizedBox(height:30),
                     Container(
                       padding: EdgeInsets.only(left:20, right:20),
                       child: Material(
                          elevation: 7.0,
                        borderRadius: BorderRadius.circular(100.0),
                         child: TextField(
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Search MVP...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredMvp = mvp.where((u)=>
                    (u.memberName.toLowerCase().contains(string.toLowerCase())||
                
                    (u.zone.toLowerCase().contains(string.toLowerCase())||
                    (u.phoneNumber.toLowerCase().contains(string.toLowerCase())||
                     (u.dateJoined.toString().toLowerCase().contains(string.toLowerCase())
                     ))))).toList();
                    });


            },
            ),
                       ),
                     ),
                  
                    
                  ],
                ),
              ),),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredMvp.length,
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
                                     
                                     children: <Widget>[
                                       Column(
                                         children: <Widget>[
                                           Row(
                                             children: <Widget>[
                                               Column(
                                                 children: <Widget>[
                                                   Text(filteredMvp[index].memberName , 
                                                   style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight: FontWeight.bold,
                                                       fontFamily: 'Monseratti'

                                                   ),),
                                                 ],
                                               ),
                                               SizedBox(width: 20),
                                              
                                             ],
                                             
                                           ),
                                           Row(children:<Widget>[
                                              Text(filteredMvp[index].branch  + "," + " " + filteredMvp[index].zone, style: TextStyle(color: Colors.grey, fontSize: 13),)
                                           ])
                                         ],
                                       ),
                                      
                                     
                                     ],
                                   ),
                                  
                                 ),
                                 
                                 SizedBox(height:2),
                                  Row(
                                    children: <Widget>[
                                    
                                   new IconButton
                                  (
                                    padding: EdgeInsets.only(left:0),
                                    icon: Icon(Icons.call,color: Colors.green, size: 30,),
                                   onPressed: ()=> launch("tel:${filteredMvp[index].phoneNumber.toString()}"),
                                  ),
                                      SizedBox(width: 5),
                                    Column(children:<Widget>[
                                      Text(filteredMvp[index].phoneNumber, style: TextStyle(fontSize:18),),
                                    ])
                                  ]
                                  ),
                                  
                                 

                                ],
                              ),
                              Spacer(),

                             Column(children:<Widget>[

                              Row(
                               children: <Widget>[
                                 Text( 'Date Joined', style: (TextStyle(color: Colors.grey)),)
                               ],
                              
                              
                              
                              ),
                              Row(
                               children: <Widget>[
                                 Text(getDate(filteredMvp[index].dateJoined) ,style: TextStyle(fontWeight:FontWeight.bold, fontSize: 15))
                               ],
                              
                              
                              
                              ),
                              SizedBox(height:25),
                              Row(
                               children: <Widget>[
                                 Text('Membership Duration', style: (TextStyle(color: Colors.grey)),)
                               ],
                              
                              
                              
                              ),
                               Row(
                               children: <Widget>[
                                 Text(filteredMvp[index].memberSince.toString() +' day(s)', style:TextStyle(fontWeight:FontWeight.bold, fontSize: 15) ,)
                               ],
                              
                              
                              
                              ),
                                  ])
                            ],
                          ),
                          
                        ),
                      )
                      ,
                    );

                  }),
            )
          ],
        )
    );
  }



  }




