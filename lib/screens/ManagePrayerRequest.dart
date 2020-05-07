import 'dart:core';



import 'package:dcapp/classes/PrayerRequestClass.dart' as prayerClass ;
import 'package:dcapp/services/PostPrayerRequestServe.dart';
import 'package:dcapp/services/PrayerRequestServ.dart';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/services/MVPServe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:progress_indicators/progress_indicators.dart';


class ManagePrayerRequest extends StatefulWidget{
 // final int subId;
 
  @override
  _ManagePrayerRequest createState() => _ManagePrayerRequest();

}
class _ManagePrayerRequest extends State<ManagePrayerRequest>{

prayerClass.PrayerRequestClass prayer = new prayerClass.PrayerRequestClass();


List<prayerClass.PrayerRequest> pr = new List<prayerClass.PrayerRequest>();
List<prayerClass.PrayerRequest> filteredPrayer = new List<prayerClass.PrayerRequest>();

  @override
  void initState() {
    super.initState();
    setState(() {


    
      new Future.delayed(Duration.zero, () {
                  loader('Loading Prayer List...');

     PostPrayerRequestService.getPrayerRequest(global.profile.member.branch.branchId).then((prayerRequestFromServer) {
        setState(() {
         prayer = prayerRequestFromServer;
         pr = prayer.prayerRequests;
         pr.removeWhere((item)=>item.branch== null);
          pr.removeWhere((item)=>item.dateRequested== null);

          filteredPrayer = pr;

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
        GestureDetector(
           onTap: (){
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
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                          )
                      ),

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

                      Text('List of Prayer Request', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredPrayer.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Prayer Request...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredPrayer = pr.where((u)=>
                    (u.request.toLowerCase().contains(string.toLowerCase())||
                    (u.branch.branchName.toLowerCase().contains(string.toLowerCase())||
                    (u.dateRequested.toString().toLowerCase().contains(string.toLowerCase()) ||
                    (u.member.firstName.toLowerCase().contains(string.toLowerCase())||
                    (u.member.surName.toLowerCase().contains(string.toLowerCase())
                   )))))).toList();
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
                  itemCount: filteredPrayer.length,
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
                          
                          Column(
                           
                            children: <Widget>[

                              Row(
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.only(left:20.0),
                                   child: Text(filteredPrayer[index].member.firstName + " "+ filteredPrayer[index].member.surName , 
                                   style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                       fontFamily: 'Monseratti'

                                   ),),
                                 ),
                                
                                
                               ],
                               
                             ),
                             SizedBox(height:7),

                                 Row(
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.only(left:20.0),
                                   child: Text(getDate(filteredPrayer[index].dateRequested).toString(), style: TextStyle(fontSize:12, color: Colors.grey)),
                                 ),
                               ],
                             ),
                              SizedBox(height:9),



                             Row(
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.only(left:20.0),
                                   child: Column(
                                     children: <Widget>[
                                       Text(filteredPrayer[index].request , 
                                       style: TextStyle(
                                            fontSize: 15.0,
                                            
                                           fontFamily: 'Monseratti'

                                       ),),
                                     ],
                                   ),
                                 ),
                                
                                
                               ],
                               
                             ),
                              SizedBox(height: 15),
                           Row(
                                children: <Widget>[
                               new IconButton(
                              
                                padding: EdgeInsets.only(left:0),
                                icon: Icon(Icons.call,color: Colors.green, size: 20,),
                               onPressed: ()=> launch("tel:${filteredPrayer[index].member.phoneNumber.toString()}"),
                              ),
                                  SizedBox(width: 5),
                                Column(children:<Widget>[
                                  Text(filteredPrayer[index].member.phoneNumber),
                                ])
                              ]
                              
                              
                              
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
        )
    );
  }



  }




