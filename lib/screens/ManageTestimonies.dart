import 'dart:core';



import 'package:dcapp/classes/TestimonyClass.dart' as testimonyClass ;
import 'package:share/share.dart';
import 'package:dcapp/services/TestimonyServe.dart';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:progress_indicators/progress_indicators.dart';


class ManageTestimony extends StatefulWidget{
 // final int subId;
 
  @override
  _ManageTestimony createState() => _ManageTestimony();

}
class _ManageTestimony extends State<ManageTestimony>{

//testimonyClass.PrayerRequestClass prayer = new prayerClass.PrayerRequestClass();
testimonyClass.TestimoniesClass testimony = new testimonyClass.TestimoniesClass();
List<testimonyClass.Testimony> test = new List<testimonyClass.Testimony>();
List<testimonyClass.Testimony> filteredTestimony = new List<testimonyClass.Testimony>();

 //List<prayerClass.PrayerRequest> pr = new List<prayerClass.PrayerRequest>();
// List<prayerClass.PrayerRequest> filteredPrayer = new List<prayerClass.PrayerRequest>();

  @override
  void initState() {
    super.initState();
    setState(() {


    
      new Future.delayed(Duration.zero, () {
                  loader('Loading Testimonies ....');

     TestimonyService.getTestimonyByBranch(global.profile.member.branch.branchId).then((testimonyFromServer) {
        setState(() {
         testimony = testimonyFromServer;
         test = testimony.testimonies;
         test.removeWhere((item)=>item.testimony== null);
          test.removeWhere((item)=>item.date== null);

          filteredTestimony = test;

         Navigator.pop(context);
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

                      Text('List of Testimonies', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredTestimony.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Testimonies...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredTestimony = test.where((u)=>
                    (u.date.toString().toLowerCase().contains(string.toLowerCase())||
                    (u.testimony.toLowerCase().contains(string.toLowerCase())||
                    (u.member.firstName.toLowerCase().contains(string.toLowerCase())||
                    (u.member.surName.toLowerCase().contains(string.toLowerCase())
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
                                   padding: const EdgeInsets.only(left:30.0),
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
                                                   Text(filteredTestimony[index].member.firstName  + " " + filteredTestimony[index].member.surName , 
                                                   style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.bold,
                                                       fontFamily: 'Monseratti'

                                                   ),),
                                                 ],
                                               ),
                                               SizedBox(width: 20),

                                             ],
                                             
                                           ),
                                           SizedBox(height:10),
                                           Row(
                                             children:<Widget>[

                                            Text(getDate(filteredTestimony[index].date).toString(), style: TextStyle(fontSize:12, color: Colors.grey)),
                                           ]),

                                            SizedBox(height: 10),

                                           Row(children:<Widget>[
                                             Text(filteredTestimony[index].testimony,style: TextStyle(fontSize: 14.0,
                                                        fontWeight: FontWeight.bold,
                                                       fontFamily: 'Monseratti')),
                                           ])
                                         ],
                                       ),
                                      
                                     
                                     ],
                                   ),
                                  
                                 ),
                                 
                                 SizedBox(height:2),
                                   Padding(
                                     padding: const EdgeInsets.all(18.0),
                                     child: Row(
                                       
                                       
                                        children: <Widget>[
                               new IconButton(
                              
                                
                                icon: Icon(Icons.call,color: Colors.green, size: 20,),
                               onPressed: ()=> launch("tel:${filteredTestimony[index].member.phoneNumber.toString()}"),
                              ),
                                  
                                Column(children:<Widget>[
                                  Text(filteredTestimony[index].member.phoneNumber),
                                ])
                              ],
                                     ),
                                   ),
                                  
                                 

                                ],
                              ),
                              Spacer(),
                              
                             Column(
                               children:<Widget>[
                                   new IconButton
                              (
                                padding: EdgeInsets.only(left:0),
                                icon: Icon(Icons.share, ),
                               onPressed: () {
                                 
                                  Share.share(filteredTestimony[index].testimony +","+" " + filteredTestimony[index].member.firstName +" "+ filteredTestimony[index].member.surName );
                                     },
                              ),
                              Row(
                               children: <Widget>[
                                // Text( filteredDisciple[index])
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




