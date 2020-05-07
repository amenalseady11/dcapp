import 'package:dcapp/classes/BranchClass.dart';
import 'package:dcapp/classes/memberClass.dart';
import 'package:dcapp/screens/MembersRegistration.dart';
import 'package:dcapp/services/MemberTrainingServ.dart';
import 'package:dcapp/services/MembersDeptServ.dart';
import 'package:flutter/cupertino.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dcapp/globals.dart' as global;
//import 'package:progress_indicators/progress_indicators.dart';

class MemberScreen extends StatefulWidget {
  // final int subId;

  @override
  _MemberScreen createState() => _MemberScreen();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _MemberScreen extends State<MemberScreen> {
  TextEditingController _firstNametextFieldController = TextEditingController();
  TextEditingController _middleNametextFieldController =
      TextEditingController();

  int memberId;
  String firstName;
  String middleName;
  String surName;
  String address;
  String city;
  String country;
  String state;
  String phoneNumber;
  String emailAddress;
  DateTime dob;
  String gender;
  String maritalStatus;
  DateTime anniversary;
  int invitedBy;
  String note;
  String status;
  bool guest;
  DateTime dateJoined;
  String pictureUrl;
  int branchid;
  int zoneid;
  int trainingId;
  int deptId;

  var getmemberbranch = global.profile.member.branch.branchId;
  int serverResponse;
  List<MemberClass> members = List();
  var filteredMembers = List();
  var filteredZones = List();
  var filteredDepts = List();
  var filteredtrainings = List();
  MemberClass memb = new MemberClass();

  List<BranchClass> filteredBranches = List();

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
                        child: GestureDetector(
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
                ),
              ],
            )));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      memb = global.members;
      filteredDepts = global.department.departments.toList();
      filteredMembers = memb.members
          .where(
              (c) => c.branch.branchId == global.profile.member.branch.branchId)
          .toList();
      filteredZones = global.zones;
      filteredtrainings = global.alltraining;
      filteredBranches = global.branches;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color: Colors.white),
          title: Text(
            'Manage  Members',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                fontFamily: 'Monseratti',
                color: Colors.white),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormTemplate();
                }));
              },
            ),
          ],
          backgroundColor: Colors.blue.shade900,
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
                          filteredMembers.length.toString(),
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
                              hintText: 'Search Members...'),
                          onChanged: (string) {
                            setState(() {
                              filteredMembers = memb.members
                                  .where((u) => (u.firstName
                                          .toLowerCase()
                                          .contains(string.toLowerCase()) ||
                                      (u.surName.toLowerCase().contains(string.toLowerCase()) ||
                                          (u.branch.branchName
                                                  .toLowerCase()
                                                  .contains(
                                                      string.toLowerCase()) ||
                                              (u.city.toLowerCase().contains(
                                                      string.toLowerCase()) ||
                                                  (u.country.toLowerCase().contains(string.toLowerCase()) ||
                                                      (u.dateJoined.toString().contains(string.toLowerCase()) ||
                                                          (u.zone.zoneName
                                                              .toLowerCase()
                                                              .contains(string.toLowerCase())))))))))
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
                  itemCount: filteredMembers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {
                          _firstNametextFieldController.text =
                              filteredMembers[index].firstName;
                          _middleNametextFieldController.text =
                              filteredMembers[index].middleName;
                          _middleNametextFieldController.text =
                              filteredMembers[index].middleName;
                        });
                      },
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                            color: Colors.blue.shade900,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  //First Column
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 60.0,
                                            height: 60.0,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'http://apekflux-001-site1.btempurl.com/v2/api/members/GetFile?memberId=' +
                                                      filteredMembers[index]
                                                          .memberId
                                                          .toString(),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors.blue,
                                                              BlendMode.dstIn),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100.0)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 20.0,
                                                          color: Colors.black),
                                                    ]),
                                              ),
                                              placeholder: (context, url) =>
                                                  Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    child:
                                                        CircularProgressIndicator(),
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ],
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            height: 30.0,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 5.0,
                                                      color: Colors.black),
                                                ],
                                                color: Colors.blue.shade900),
                                            child: Text(
                                              filteredMembers[index].firstName +
                                                  ' ' +
                                                  filteredMembers[index]
                                                      .middleName +
                                                  ' ' +
                                                  filteredMembers[index]
                                                      .surName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                  fontFamily: 'Monseratti'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  new IconButton(
                                                      padding: EdgeInsets.only(
                                                          left: 0),
                                                      icon: Icon(
                                                        Icons.group_add,
                                                        color: Colors
                                                            .blue.shade900,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {
                                                        global.membdetName =
                                                            filteredMembers[
                                                                        index]
                                                                    .surName +
                                                                " " +
                                                                filteredMembers[
                                                                        index]
                                                                    .firstName
                                                                    .toString();
                                                        global.getmemberId =
                                                            filteredMembers[
                                                                    index]
                                                                .memberId;
                                                        _displaydeptDialog(
                                                            context);
                                                      }),
                                                ],
                                              ),
                                              Row(children: <Widget>[
                                                Text(
                                                  "Add to department",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ]),
                                              //Call Icon
                                            ],
                                          ),
                                          SizedBox(width: 40),
                                          Column(
                                            children: <Widget>[
                                              //SMS Icon
                                              Row(
                                                children: <Widget>[
                                                  new IconButton(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    icon: Icon(
                                                      Icons.group_add,
                                                      color:
                                                          Colors.blue.shade900,
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      global.membdetName =
                                                          filteredMembers[index]
                                                                  .surName +
                                                              " " +
                                                              filteredMembers[
                                                                      index]
                                                                  .firstName
                                                                  .toString();
                                                      global.getmemberId =
                                                          filteredMembers[index]
                                                              .memberId;
                                                      _displaytrainingDialog(
                                                          context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    "Add  trainings",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Spacer(),
                                  //Second Column
                                  Column(
                                    children: <Widget>[
                                      // general column for phone number
                                      Row(
                                        children: <Widget>[
                                          //column for icon
                                          Column(
                                            children: <Widget>[
                                              new IconButton(
                                                padding:
                                                    EdgeInsets.only(left: 0),
                                                icon: Icon(
                                                  Icons.phone,
                                                  color: Colors.green,
                                                  size: 30,
                                                ),
                                                onPressed: () => launch(
                                                    "tel:${filteredMembers[index].phoneNumber.toString()}"),
                                              ),
                                            ],
                                          ),
                                          //column for phone detail
                                          Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Phone Number',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11.0,
                                                        fontFamily:
                                                            'Monseratti'),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    filteredMembers[index]
                                                        .phoneNumber,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        fontFamily:
                                                            'Monseratti'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Email Address',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11.0,
                                                fontFamily: 'Monseratti'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                filteredMembers[index]
                                                    .emailAddress,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 9.0,
                                                    fontFamily: 'Monseratti'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Branch',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                                fontFamily: 'Monseratti'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            filteredMembers[index]
                                                        .branch
                                                        .branchName ==
                                                    null
                                                ? 'No Branch'
                                                : filteredMembers[index]
                                                    .branch
                                                    .branchName,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                fontFamily: 'Monseratti'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Zone',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                                fontFamily: 'Monseratti'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                filteredMembers[index]
                                                            .zone
                                                            .zoneName ==
                                                        null
                                                    ? 'No Zone'
                                                    : filteredMembers[index]
                                                        .zone
                                                        .zoneName,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0,
                                                    fontFamily: 'Monseratti'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
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

  _displaytrainingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(global.membdetName),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SearchableDropdown.single(
                    hint: Text('Add Training'),
                    isExpanded: false,
                    items: filteredtrainings
                        .map((value) => DropdownMenuItem(
                              child: Text(value.trainingName.toString()),
                              value: value.trainingId,
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        trainingId = newValue;
                      });
                    }),
              ],
            ),
            actions: <Widget>[
              new RaisedButton(
                  color: Colors.blue.shade900,
                  child: new Text('Save'),
                  onPressed: () {
                    new Future.delayed(Duration.zero, () {
                      loader('Adding Member...');

                      MembersTrainingService.postMembTraining(
                              trainingId, global.getmemberId)
                          .then((responseFromServer) {
                        setState(() {
                          serverResponse = responseFromServer;
                          if (serverResponse == 1) {
                            Navigator.pop(context);
                            dialog('Record Added ');
                          } else {
                            Navigator.pop(context);
                            dialog('Error Adding Record');
                          }
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

  _displaydeptDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(global.membdetName),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SearchableDropdown.single(
                    hint: Text('Select Department'),
                    isExpanded: false,
                    items: filteredDepts
                        .map((value) => DropdownMenuItem(
                              child: Text(value.departmentName.toString()),
                              value: value.departmentId,
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        deptId = newValue;
                      });
                    }),
              ],
            ),
            actions: <Widget>[
              new RaisedButton(
                  color: Colors.blue.shade900,
                  child: new Text('Save'),
                  onPressed: () {
                    new Future.delayed(Duration.zero, () {
                      loader('Adding Member...');
                      MembersDepartmentService.postMembDept(
                              global.profile.member.branch.branchId,
                              deptId,
                              global.getmemberId)
                          .then((responseFromServer) {
                        setState(() {
                          serverResponse = responseFromServer;
                          if (serverResponse == 1) {
                            Navigator.pop(context);
                            dialog('Record Added ');
                          } else {
                            Navigator.pop(context);
                            dialog('Error Adding Record');
                          }
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
