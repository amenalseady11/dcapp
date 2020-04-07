import 'dart:core';
import 'dart:io';
import 'package:dcapp/classes/MeetingClass.dart' as meet;
import 'package:dcapp/services/DeptHeadServ.dart';
import 'package:dcapp/services/MeetingServ.dart';
import 'package:dcapp/services/ZoneHeadServ.dart';
import 'package:dcapp/services/zoneServ.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';



import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:dcapp/classes/MeetingRoom.dart';

//import 'package:progress_indicators/progress_indicators.dart';


class Meeting extends StatefulWidget{
 // final int subId;
 
  @override
  _Meeting createState() => _Meeting();

}
class _Meeting extends State<Meeting>{

  
List<meet.Meeting> _meetings = List<meet.Meeting>();
List<meet.Meeting> filteredMeeting = List<meet.Meeting>();
List<MeetingRooms> meetingRooms = new List<MeetingRooms>();
List<MeetingRooms> meetingRoomsList = new List<MeetingRooms>();
MeetingRooms meetingRoom = new MeetingRooms();
var discipleshipTraining;


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
    
    meetingRoom.roomTitle ='Sunday Service';
    meetingRoom.roomId ='sundayservice'+ global.profile.member.branch.branchId.toString();

    meetingRooms.add(meetingRoom);

    meetingRoom = new MeetingRooms();
    meetingRoom.roomTitle ='Mid Week Service';
    meetingRoom.roomId ='midweek'+ global.profile.member.branch.branchId.toString();
    meetingRooms.add(meetingRoom);

    if(global.profile.member.zone.zoneId!=null){
      meetingRoom = new MeetingRooms();
      meetingRoom.roomTitle = global.profile.member.zone.zoneName + ' Meeting Room';
      meetingRoom.roomId ='zonemeet'+ global.profile.member.zone.zoneId.toString();
      meetingRooms.add(meetingRoom);

    }

  if(global.profile.deptTable.length>0){
      meetingRoom = new MeetingRooms();
       meetingRoom.roomTitle = "Worker's Meeting Room";
      meetingRoom.roomId ='workers'+ global.profile.member.branch.branchId.toString();
      meetingRooms.add(meetingRoom);


      global.profile.deptTable.forEach((f){
        meetingRoom = new MeetingRooms();
      meetingRoom.roomTitle = f.department + ' Meeting Room';
      var deptID =f.department.replaceAll(" ", "");
      meetingRoom.roomId = deptID + global.profile.member.branch.branchId.toString();
      meetingRooms.add(meetingRoom);
      });

    }

    if(global.profile.position=='Pastor'){
      meetingRoom = new MeetingRooms();
      meetingRoom.roomTitle = "Pastor's Meeting Room";
      meetingRoom.roomId ='past'+ global.profile.member.branch.branchId.toString();
      meetingRooms.add(meetingRoom);

    }

    ZoneHeadService.checkifzone(global.profile.member.memberId).then((response){
      if(response=='Yes'){
        meetingRoom = new MeetingRooms();
      meetingRoom.roomTitle = "Zone Head Meeting Room";
      meetingRoom.roomId ='zonehead'+ global.profile.member.branch.branchId.toString();
      meetingRooms.add(meetingRoom);
      }
    });
   DepartmentHeadService.checkifdepthead(global.profile.member.memberId).then((response){
      if(response.status=='Yes'){
        meetingRoom = new MeetingRooms();
      meetingRoom.roomTitle = "Department Head Meeting Room";
      meetingRoom.roomId ='depthead'+ global.profile.member.branch.branchId.toString();
      meetingRooms.add(meetingRoom);
      }
    });


        setState(() {

          meetingRoomsList = meetingRooms;
        });
     
     });
 
  }
   
  
    



  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MMM-dd HH:mm');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
  }

 

Future<MeetingRooms> getMeetingStatus(String meetingTitle, int index) async{
   var response = await MeetingService.getmeetingStatus(
            global.profile.member.branch.branchId, meetingTitle);
      
      if (response != null) {
        if (response.meetings.length > 0) {
          if (response.meetings[0].status == "Open") {
              meetingRoomsList[index].status = response.meetings[0].status;
              MeetingRooms rm = new MeetingRooms();

              rm.status = "Open";
              rm.startTime =response.meetings[0].startTime;
              return rm;

          } else {
             meetingRoomsList[index].status ='Closed';
           MeetingRooms rm = new MeetingRooms();

              rm.status = "Closed";
            
              return rm;
          }
        }else{
            meetingRoomsList[index].status ='Closed';
          MeetingRooms rm = new MeetingRooms();

              rm.status = "Closed";
            
              return rm;

        }
      } else {
          meetingRoomsList[index].status ='Closed';
       MeetingRooms rm = new MeetingRooms();

              rm.status = "Closed";
            
              return rm;
      }
             
  }

_joinMeeting(String room, String subject, String displayName, String email) async {
    try {
      var options = JitsiMeetingOptions()
        ..room = room // Required, spaces will be trimmed
        ..serverURL = ""
        ..subject = subject
        ..userDisplayName = displayName
        ..userEmail = email
        ..audioOnly = true
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
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
        ]
        
        ),
        actions: <Widget>[
            ],
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

                     // Text('There are zero Active Meeting', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                        Text("Meeting Rooms", style: TextStyle(color: Colors.white, fontSize: 20),),
                        SizedBox(width:5),
                      Text("(" + meetingRoomsList.length.toString() +")", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                    ],),
                    SizedBox(height:30),
                  ],
                ),
              ),),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: meetingRoomsList.length,
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
                                     Container(
                                    width: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text( meetingRoomsList[index].roomTitle , 
                                        style: TextStyle(
                                             fontSize: 18.0,
                                             
                                            fontFamily: 'Monseratti'

                                        ),),
                                        SizedBox(width: 20),

                                      ],
                                      
                                    ),
                                  ),
                                  Spacer(),
                                 Column(
                                   children:<Widget>[
                                     new RaisedButton(
                                     color: Colors.blue,
                                     child: new Text('Join',style: TextStyle(color:Colors.white),),
                                   onPressed: () async {

                                     bool res = await checkconnectivity();
                                           if (!res) {
                                    dialog("Internet Required, Check your Network Connection");
                                      return;
                                         }
                                    
                                    if(meetingRoomsList[index].status=="Open"){
                                     _joinMeeting(meetingRoomsList[index].roomId, meetingRoomsList[index].roomTitle, global.profile.member.firstName +' '+ global.profile.member.surName, global.profile.member.emailAddress);
                                    }else{
                                      dialog('Meeting Room is not available at the moment');
                                    }
                                     },
                                      ),
                                  Row(
                                   children: <Widget>[
                                    
                                   ],
                                  ),
                                      ])
                                ],
                              ),

                               Row(
                                     children: <Widget>[
                                       FutureBuilder<MeetingRooms>(
                                future: getMeetingStatus(meetingRoomsList[index].roomTitle, index),
                                builder: (context, snapshot) {
                                       if (snapshot.hasData) {
                                         if(snapshot.data.status=="Open"){
                                           return Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                              Text('Open', style: TextStyle(color:Colors.green, fontWeight:FontWeight.bold),),
                                              SizedBox(width:10),
                                              Row(
                                                children: <Widget>[
                                                  Text('Start Time:', style: TextStyle(fontWeight: FontWeight.bold),),
                                                  SizedBox(width:10),
                                                  Text(getDate(snapshot.data.startTime)),
                                                ],
                                              )
                                           ],);

                                         }else{
                                            return Row(children: <Widget>[
                                              Text('Closed', style: TextStyle(color:Colors.red, fontWeight:FontWeight.bold),),
                                             
                                           ],);

                                         }
                                         
                                       }
                                        return Container(
                                          width: 10,
                                          height: 10,
                                          child: CircularProgressIndicator());
                                       }
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
        )
    );
  }

  joinMeeting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
      //    return MeetingWidget(meetingId:  global.meetingId, meetingPassword: global.meetingPassword);
        },
      ),
    );
  }

  }




