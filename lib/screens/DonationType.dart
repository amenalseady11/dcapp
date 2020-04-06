import 'dart:core';



import 'package:dcapp/classes/DonationTypeClass.dart' as donationTypeClass;


import 'package:dcapp/globals.dart' as global;

import 'package:dcapp/services/DonationTypeServe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';


//import 'package:progress_indicators/progress_indicators.dart';


class Donation extends StatefulWidget{
 // final int subId;
 
  @override
  _Donation createState() => _Donation();

}

class Debouncer{
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.milliseconds});

  run(VoidCallback action){
    if (null != _timer){
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

}
class _Donation extends State<Donation>{

  
 TextEditingController _donationNametextFieldController = TextEditingController();
 TextEditingController _notetextFieldController = TextEditingController();
    
     String donName;
     String notes;



   List<donationTypeClass.DonationType> don =  List<donationTypeClass.DonationType>();

    var filteredDonation = List();

  @override
  void initState() {
    super.initState();
    setState(() {
         new Future.delayed(Duration.zero, () {
                  loader('Loading Donation Type...');
     DonationTypeService.getDonationType().then((donFromServer) {
        setState(() {
          global.donationtype = donFromServer;
          global.donationtype.donationTypes.removeWhere((item) => item.donationName  == null);
          global.donationtype.donationTypes.removeWhere((item) => item.note  == null);
          don = global.donationtype.donationTypes;
          filteredDonation = don;
          Navigator.pop(context);
         // 
        });
      });
         });

   });
  }
    
    String serviceName;
    int serverResponse;

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
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Manage  Donation Type', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),
          actions: <Widget>[

            new IconButton(icon: new Icon(Icons.add,color: Colors.white,),onPressed: (){_displayDialog(context);},),

          ],
          backgroundColor: Colors.blue.shade900,

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

                      Text('Number of Donation Types', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredDonation.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Donation Types...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredDonation = don.where((u)=>
                    (u.donationName.toLowerCase().contains(string.toLowerCase()))||
                    (u.note.toLowerCase().contains(string.toLowerCase()))
                    ).toList();
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
                  itemCount: filteredDonation.length,
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
                             Padding(
                               padding: const EdgeInsets.only(left:18.0),
                               child: Column(
                                 
                                 children: <Widget>[
                                   Column(
                                     children: <Widget>[
                                       Row(
                                         children: <Widget>[
                                           Text(filteredDonation[index].donationName, 
                                           style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                               fontFamily: 'Monseratti'

                                           ),),
                                          
                                         
                                          
                                         ],
                                         
                                       ),
                                     ],
                                   ),
                                     SizedBox(height: 20),
                                   Row(children:<Widget>[
                                             Text(
                                               filteredDonation[index].note, 
                                           style: TextStyle(
                                                fontSize: 15.0,
                                                
                                               fontFamily: 'Monseratti'

                                           ),
                                             )
                                           ]),
                                 ],
                               ),
                              
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



 _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(' Add/Update Service'),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextField(
                  controller: _donationNametextFieldController,
                  decoration: InputDecoration(hintText: "Enter Donation Type"),
                  onChanged: (String value) {
                        donName = value;
                  },
                ),
                TextField(
                  controller: _notetextFieldController,
                  maxLines: 2,
                  decoration: InputDecoration(hintText: "Notes"),
                  onChanged: (String value) {
                  notes = value;
                  },
                )
              ],
            ),
            
            actions: <Widget>[
              new RaisedButton(
                color: Colors.blue.shade900,
                child: new Text('Save'),
                onPressed: () {
                  //save to server
                 new Future.delayed(Duration.zero, () {
                  loader('Saving Donation Type...');

                 

                    DonationTypeService.saveDonationType(_donationNametextFieldController.text, _notetextFieldController.text).then((responseFromServer) {
                    setState(() {
                    serverResponse = responseFromServer;
                   if(serverResponse !=null){
                        donationTypeClass.DonationType de = new donationTypeClass.DonationType();

                    int id = serverResponse;
                    de.id = id;
                    
                    de.donationName = _donationNametextFieldController.text;
                    de.note = _notetextFieldController.text;
                    global.donationtype.donationTypes.add(de);
                    filteredDonation= global.donationtype.donationTypes;
                   }
                    Navigator.pop(context);
                    dialog('Donation Type Saved');
                    });
                   });
                 });
                }),

                new RaisedButton(
                color: Colors.red,
                child: new Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              new RaisedButton(
                color: Colors.grey,
                child: new Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
                ]
          );},
          );
        }
  }




