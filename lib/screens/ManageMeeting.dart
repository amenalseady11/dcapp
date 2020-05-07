import 'dart:core';
import 'package:dcapp/classes/MeetingRoom.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/classes/MeetingClass.dart' as meet;
import 'package:dcapp/services/MeetingServ.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:intl/intl.dart';

class ManageMeeting extends StatefulWidget {
  @override
  _ManageMeeting createState() => _ManageMeeting();
}

class _ManageMeeting extends State<ManageMeeting> {
  List<meet.Meeting> _meetings = List<meet.Meeting>();
  List<MeetingRooms> meetingRooms = new List<MeetingRooms>();
  List<MeetingRooms> meetingRoomsList = new List<MeetingRooms>();
  MeetingRooms meetingRoom = new MeetingRooms();

  String datePicked;
  TextEditingController meetingTime = new TextEditingController();
  int serverResponse;
  List<String> _status = [
    'Open',
    'Closed',
  ]; // Option 2
  String _selectedStatus;

  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MMM-dd HH:mm');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
  }

  @override
  void initState() {
    super.initState();

   
      
        if (global.checkifbranchhead == 'Yes') {
          meetingRoom = new MeetingRooms();
          meetingRoom.roomTitle = "Sunday Service";
          meetingRoom.roomId = 'sundayservice' +
              global.profile.member.branch.branchId.toString();
          meetingRooms.add(meetingRoom);

          meetingRoom = new MeetingRooms();
          meetingRoom.roomTitle = "Mid Week Service";
          meetingRoom.roomId =
              'midweek' + global.profile.member.branch.branchId.toString();
          meetingRooms.add(meetingRoom);

          meetingRoom = new MeetingRooms();
          meetingRoom.roomTitle = "Worker's Meeting Room";
          meetingRoom.roomId =
              'workers' + global.profile.member.branch.branchId.toString();
          meetingRooms.add(meetingRoom);

          meetingRoom = new MeetingRooms();
          meetingRoom.roomTitle = "Pastor's Meeting Room";
          meetingRoom.roomId =
              'pastors' + global.profile.member.branch.branchId.toString();
          meetingRooms.add(meetingRoom);

          meetingRoom = new MeetingRooms();
          meetingRoom.roomTitle = "Department Head Meeting Room";
          meetingRoom.roomId =
              'depthead' + global.profile.member.branch.branchId.toString();
          meetingRooms.add(meetingRoom);

          meetingRoom = new MeetingRooms();
          meetingRoom.roomTitle = "Zone Head Meeting Room";
          meetingRoom.roomId =
              'zonehead' + global.profile.member.branch.branchId.toString();
          meetingRooms.add(meetingRoom);
         
        }
      

      if (global.checkifzonehead == 'Yes') {
          meetingRoom = new MeetingRooms();
          meetingRoom.roomTitle =
              global.profile.member.zone.zoneName + ' Zone Meeting Room';
          meetingRoom.roomId =
              'zone' + global.profile.member.zone.zoneId.toString();
          meetingRooms.add(meetingRoom);
         
        }
     

     if (global.checkifdepthhead == 'Yes') {
          meetingRoom = new MeetingRooms();
          meetingRoom.roomTitle = global.departmentheadDept + ' Department Meeting Room';
          meetingRoom.roomId =
              'depthead' + global.profile.member.branch.branchId.toString();
          meetingRooms.add(meetingRoom);
         
        }
     
          setState(() {
            meetingRoomsList = meetingRooms;
          });
    
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
          actions: <Widget>[],
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            Card(
              elevation: 15.0,
              margin: EdgeInsets.only(top: 0),
              child: Container(
                height: 150.0,
                color: Colors.blue.shade900,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Manage Meetings',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: meetingRoomsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {});
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          meetingRoomsList[index].roomTitle,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Monseratti'),
                                        ),
                                        SizedBox(width: 20),
                                      ],
                                    ),
                                  ),
                                    
                                  Spacer(),
                                  Column(children: <Widget>[
                                    new RaisedButton(
                                      color: Colors.blue,
                                      child: new Text(
                                        'Settings',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        global.clickTitle =
                                            meetingRoomsList[index].roomTitle;
                                        _displayDialog(context);
                                      },
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
                      ),
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
                Text(
                  global.clickTitle,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  readOnly: true,
                  controller: meetingTime,
                  decoration: InputDecoration(
                    labelText: 'Select meeting Time',
                    labelStyle: TextStyle(
                        fontFamily: 'MontSerrat', fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onChanged: (date) {
                      setState(() {
                        meetingTime.text = date.toString();
                      });

                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      setState(() {
                        meetingTime.text = date.toString();
                      });
                    },
                        currentTime: DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            DateTime.now().hour,
                            DateTime.now().minute),
                        locale: LocaleType.en);
                  },
                ),
                SizedBox(height: 10),
                DropdownButton(
                  hint: Text('Select Status'), // Not necessary for Option 1
                  value: _selectedStatus,
                  items: _status.map((meet) {
                    return DropdownMenuItem(
                      child: new Text(meet),
                      value: meet,
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStatus = newValue;
                      Navigator.pop(context);
                      _displayDialog(context);
                    });
                  },

                  isExpanded: true,
                  style: TextStyle(
                      fontFamily: 'Monserrati',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54),
                ),
                SizedBox(height: 5),
              ],
            ),
            actions: <Widget>[
              new RaisedButton(
                  color: Colors.blue.shade900,
                  child: new Text('Save'),
                  onPressed: () {
                    new Future.delayed(Duration.zero, () {
                      loader('Saving Schedule...');

                      var dt;
                      if (meetingTime.text == null ||
                          meetingTime.text.length <= 0) {
                        dt = DateTime.now().toString();
                      } else {
                        dt = meetingTime.text;
                      }
                      // datePosted= DateTime.now();

                      MeetingService.postMeeting(
                              global.profile.member.branch.branchId,
                              global.clickTitle,
                              dt,
                              _selectedStatus)
                          .then((responseFromServer) {
                        setState(() {
                          serverResponse = responseFromServer;
                          Navigator.pop(context);
                          dialog('Meeting Saved');
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
            ]);
      },
    );
  }
}
