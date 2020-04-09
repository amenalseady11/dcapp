import 'dart:core';
import 'package:dcapp/classes/DiscipleshipStatusClass.dart' as disciple;
import 'package:dcapp/screens/DiscipleshipTrainingDetail.dart';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/services/DiscipleshipStatusServe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/classes/memberClass.dart' as MemClass;
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

//import 'package:progress_indicators/progress_indicators.dart';

class DiscipleshipStatus extends StatefulWidget {
  // final int subId;

  @override
  _DiscipleshipStatus createState() => _DiscipleshipStatus();
}

class _DiscipleshipStatus extends State<DiscipleshipStatus> {
  int branchID;
  int memberID;
  int trainingID;
  DateTime datJoined;
  var filteredMembers = List();
  MemClass.MemberClass _memberClass = new MemClass.MemberClass();
  disciple.DiscipleshipStatusClass discipleclass =
      new disciple.DiscipleshipStatusClass();
  List<disciple.Discipleshipstatus> disc =
      new List<disciple.Discipleshipstatus>();
  List<disciple.Discipleshipstatus> filteredDisciple =
      new List<disciple.Discipleshipstatus>();
  List<disciple.DiscipleshipStatusClassTraining> alltraining =
      new List<disciple.DiscipleshipStatusClassTraining>();
  List<disciple.DiscipleshipstatusTraining> disctrain =
      new List<disciple.DiscipleshipstatusTraining>();
  var discipleshipTraining;

//DiscipleshipStatusClassTraining dtrain = new DiscipleshipStatusClassTraining();

  @override
  void initState() {
    super.initState();
    setState(() {
      ///var trainingIndex = disc.length/alltraining.length  * 100;

      // var discipleTraining = disctrain.where((u)=>u.status.index == 'Done');

      new Future.delayed(Duration.zero, () {
        loader(' Loading  Status ...');

        DiscipleshipStatuservice.getDiscipleshipStatus(
                global.profile.member.branch.branchId)
            .then((discipleFromServer) {
          setState(() {
            discipleclass = discipleFromServer;
            disc = discipleclass.discipleshipstatus;
            _memberClass = global.members;
            filteredMembers = _memberClass.members;
            disc.removeWhere((item) => item.branch == null);
            disc.removeWhere((item) => item.memberName == null);
            alltraining = discipleclass.trainings;
            filteredDisciple = disc;
            global.alltraining = alltraining;
            global.discipletraining = disc;
            global.memberId = filteredDisciple[0].memberId;

            Navigator.pop(context);
          });
        });
      });
    });
  }

  getIndex(int index) {
    int tcount = 0;
    disctrain = filteredDisciple[index].training;

    disctrain.forEach((item) {
      if (item.status == "Done") {
        tcount = tcount + 1;
      }
    });

    if (tcount == 0) {
      return 0;
    } else {
      return tcount * 100 / alltraining.length;
    }
  }

  getmemberPhone(int memberId) {
    var phone =
        global.members.members.where((u) => u.memberId == memberId).toList();

    if (phone.length <= 0) {
      return Column(
        children: <Widget>[
          Text(
            'Phone Number not available or zone not selected',
            style: TextStyle(color: Colors.red, fontSize: 10),
          ),
        ],
      );
    }
    return Row(
      children: <Widget>[
        new IconButton(
          padding: EdgeInsets.only(left: 0),
          icon: Icon(
            Icons.call,
            color: Colors.green,
            size: 25,
          ),
          onPressed: () => launch("tel:${phone[0].phoneNumber.toString()}"),
        ),
        Text(
          phone[0].phoneNumber,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MM-dd');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
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
                Container(
                  height: 40.0,
                  child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.blue.shade900,
                      color: Colors.blue.shade900,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            'Back to List',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontSerrat'),
                          ),
                        ),
                      )),
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
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 40)),
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
          actions: <Widget>[
             new IconButton(icon: new Icon(Icons.add,color: Colors.blue.shade900,),onPressed: (){_displayDialog(context);},),
          ],
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
                          'Number of Members',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          filteredDisciple.length.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Material(
                        elevation: 7.0,
                        borderRadius: BorderRadius.circular(100.0),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: 'Search Member...'),
                          onChanged: (string) {
                            setState(() {
                              filteredDisciple = disc
                                  .where((u) => (u.memberName
                                          .toLowerCase()
                                          .contains(string.toLowerCase()) ||
                                      (u.training
                                          .toString()
                                          .toLowerCase()
                                          .contains(string.toLowerCase()))))
                                  .toList();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredDisciple.length,
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
                          child: Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      filteredDisciple[index]
                                                          .memberName,
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Monseratti'),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 20),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(children: <Widget>[
                                              getmemberPhone(
                                                  filteredDisciple[index]
                                                      .memberId)
                                            ])
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Discipleship Level:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 20),
                                        Row(children: <Widget>[
                                          Text(
                                            getIndex(index).toString() + ' %',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ]),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(children: <Widget>[
                                new IconButton(
                                  padding: EdgeInsets.only(left: 0),
                                  icon: Icon(
                                    Icons.arrow_right,
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      global.membername =
                                          filteredDisciple[index].memberName;
                                      global.memberId =
                                          filteredDisciple[index].memberId;

                                      return MemberTraingDetail();
                                    }));
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
                Text(" Add Member's  Trainings"),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                
                
                 SearchableDropdown.single(
                   hint: Text('Select Member'),
                    isExpanded: false,
                    value: memberID,
                  items: filteredMembers.where((u)=>
                    (u.branch.branchId==global.profile.member.branch.branchId)).toList()
                  
                  .map((value) => DropdownMenuItem(
                                child: Text(value.firstName +" " + value.surName),
                                value: value.memberId,
                              ))
                      .toList(),
                  onChanged: (newValue) {
              setState(() {
                
                memberID = newValue;
              });
            }
                ),
                 SearchableDropdown.single(
                 hint: Text('Select Training'),
                   isExpanded: false,
                   
                  items: alltraining
                  
                 .map((value) => DropdownMenuItem(
                             child: Text(value.trainingName.toString()),
                               value: value.trainingId,
                             ))
                    .toList(),
                  onChanged: (newValue) {
             setState(() {
                
               trainingID = newValue;
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
                  
      //            new Future.delayed(Duration.zero, () {
      //             loader('Adding Member...');

      //             datJoined= DateTime.now();

      //               DepartmentHeadService.saveDeptHead(memberID,branchID,  deptID, datePosted,  status,).then((responseFromServer) {
                      
      //               setState(() {
      //               serverResponse = responseFromServer;
      //              if(serverResponse !=null){
      //                    setState(() {
      //                      DepartmentHeadService.getDeptHead().then((deptheadFromServer) {
      //   setState(() {
      //     global.departmentHead = deptheadFromServer;
      //     global.departmentHead.departmentHeads.removeWhere((item) => item.department.departmentName == null);
      //     deptsHeads= global.departmentHead.departmentHeads;
      //     filteredDeptHeads = deptsHeads;
      //   });
        
      // });
      //            });
      
      //              }
      //               Navigator.pop(context);
      //               dialog('Department Head Saved');
      //               });
      //              });
      //            });
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
