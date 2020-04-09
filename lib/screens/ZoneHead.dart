import 'dart:core';
import 'package:dcapp/classes/BranchClass.dart';
import 'package:dcapp/classes/ZoneHeadClass.dart' as zonesheadsClass;
import 'package:dcapp/classes/memberClass.dart' as MemClass;
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/classes/zoneClass.dart';
import 'package:dcapp/services/ZoneHeadServ.dart';
import 'package:flutter/cupertino.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:progress_indicators/progress_indicators.dart';


class ZoneHead extends StatefulWidget{
 // final int subId;
 
  @override
  _ZoneHead createState() => _ZoneHead();

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
class _ZoneHead extends State<ZoneHead>{

  
 
 var filteredZones = List();

  List<BranchClass> filteredBranches = List();
 var filteredMembers = List();
  MemClass.MemberClass _memberClass = new MemClass.MemberClass();

  List<ZoneClass> zn = List<ZoneClass>();
   List<zonesheadsClass.ZoneHead> zoneheads =  List<zonesheadsClass.ZoneHead>();

   var filteredZoneHeads  = List();

  @override
  void initState() {
    super.initState();
    setState(() {
     zn =global.zones;
    // filteredZones = zn;
    
     filteredBranches=global.branches;
     _memberClass = global.members;
   filteredMembers = _memberClass.members;
      new Future.delayed(Duration.zero, () {
                  loader('Loading Zone Head...');

     ZoneHeadService.getZoneHead().then((zoneheadFromServer) {
        setState(() {
          global.zoneHead = zoneheadFromServer;
          global.zoneHead.zoneHeads.removeWhere((item) => item.zone.zoneName == null);
          zoneheads= global.zoneHead.zoneHeads;
          filteredZoneHeads = zoneheads.where((c)=>c.zone.branch.branchId == global.profile.member.branch.branchId).toList();
         Navigator.pop(context);
        });
      });
      });

   });
  }
    int zoneID;
    int serverResponse;
    int zoneId;
    int branchID;
    int memberId;
    DateTime datePosted;
    String status;

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
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Manage  Zone Head', style: TextStyle(
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

                      Text('Number of Zone Head', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredZoneHeads.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Zone Head...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredZoneHeads = zoneheads.where((u)=>
                    (u.zone.zoneName.toLowerCase().contains(string.toLowerCase())||
                
                    (u.memberId.surName.toLowerCase().contains(string.toLowerCase())
                
                   ))).toList();
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
                  itemCount: filteredZoneHeads.length,
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
                                           Column(
                                             children: <Widget>[
                                               Text(filteredZoneHeads[index].memberId.surName + " " + filteredZoneHeads[index].memberId.firstName, 
                                               style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                   fontFamily: 'Monseratti'

                                               ),),
                                             ],
                                           ),
                                           SizedBox(width: 20),
                                           Column(
                                             children:<Widget>[
                                             Text('(${filteredZoneHeads[index].zone.zoneName.toString()})',style: TextStyle(fontWeight:FontWeight.bold),)
                                           ])
                                         ],
                                         
                                       ),
                                     ],
                                   ),
                                   Column(children:<Widget>[
                                     
                                   ])
                                 ],
                               ),
                              
                             ),
                             
                             SizedBox(height:2),
                              Row(
                                children: <Widget>[
                                
                               new IconButton
                              (
                                padding: EdgeInsets.only(left:0),
                                icon: Icon(Icons.call,color: Colors.green, size: 20,),
                               onPressed: ()=> launch("tel:${filteredZoneHeads[index].memberId.phoneNumber.toString()}"),
                              ),
                                  SizedBox(width: 5),
                                Column(children:<Widget>[
                                  Text(filteredZoneHeads[index].memberId.phoneNumber, style: TextStyle(fontSize:20),),
                                ])
                              ]
                              ),
                              
                              Row(
                                children: <Widget>[
                               new IconButton(
                              
                                padding: EdgeInsets.only(left:0),
                                icon: Icon(Icons.email,color: Colors.red, size: 20,),
                               onPressed: ()=> launch("mailto:${filteredZoneHeads[index].memberId.emailAddress.toString()}"),
                              ),
                                  SizedBox(width: 5),
                                Column(children:<Widget>[
                                  Text(filteredZoneHeads[index].memberId.emailAddress),
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



 _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(' Add/Update Zone Head'),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SearchableDropdown.single(
                                   
                  value: branchID,
                  items: filteredBranches
                      .map((value) => DropdownMenuItem(
                        
                                    child: Text(value.branchName),
                                    value: value.branchID,
                                  ))
                      .toList(),
                  onChanged: (int value) {
                    setState(() {
                      branchID = value;
                       filteredZones = zn.where((u)=>
                    (u.branch.branchId==branchID)).toList();

                       Navigator.of(context).pop();
                    _displayDialog(context);
                     

                    });
                       
                   

                     // print(filteredZones.length.toString());
                  },
                  isExpanded: false,
                  hint: Text('Select  Branch'),
                  
                ),
                  SearchableDropdown.single(
                   hint: Text('Select Zone'),
                   value: zoneID,
                    isExpanded: false,
                  items: filteredZones
                  
                  .map((value) => DropdownMenuItem(
                                child: Text(value.zoneName),
                                value: value.zoneId,
                              ))
                      .toList(),
                  onChanged: (newValue) {
              setState(() {
                zoneID = newValue;
                      Navigator.of(context).pop();
                        _displayDialog(context);
                    
              });
            }
                  
                ),

                 SearchableDropdown.single(
                   hint: Text('Select Member'),
                   value: memberId,
                    isExpanded: false,
                  items: filteredMembers.where((u)=>
                    (u.branch.branchId==branchID) ).toList()
                  
                  .map((value) => DropdownMenuItem(
                                child: Text(value.firstName +" " + value.surName),
                                value: value.memberId,
                              ))
                      .toList(),
                  onChanged: (newValue) {
              setState(() {
                 
                memberId = newValue;
              });
            }
                 
                 
                  
                ),
              ],
            ),
            
            actions: <Widget>[
              new RaisedButton(
                color: Colors.blue.shade900,
                child: new Text('Save'),
                onPressed: () {
                  //save to server
                 new Future.delayed(Duration.zero, () {
                  loader('Saving Zone Head...');

                  datePosted= DateTime.now();

                    ZoneHeadService.saveZoneHead(zoneID, memberId, datePosted, status).then((responseFromServer) {
                    setState(() {
                    serverResponse = responseFromServer;
                   if(serverResponse !=null){
                     ZoneHeadService.getZoneHead().then((zoneheadFromServer) {
        setState(() {
          global.zoneHead = zoneheadFromServer;
          global.zoneHead.zoneHeads.removeWhere((item) => item.zone.zoneName == null);
          zoneheads= global.zoneHead.zoneHeads;
          filteredZoneHeads = zoneheads;
         // 
        });
      });
                   }
                    Navigator.pop(context);
                    dialog('Zone Head Saved');
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




