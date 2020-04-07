import 'package:dcapp/classes/memberClass.dart' as MemClass;
import 'package:dcapp/services/memberServ.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/classes/BranchClass.dart';
import 'package:dcapp/classes/zoneClass.dart';

import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;

class FormTemplate extends StatefulWidget {
  @override
  _FormTemplate createState() => _FormTemplate();
}

class _FormTemplate extends State<FormTemplate> {
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
  String pictureURL;
  int serverResponse;
  bool guest;
  DateTime dateJoined;
  String pictureUrl;
  int branchID;
  int zoneID;
  int memberId;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController datejoinedController = TextEditingController();
  TextEditingController anniversaryController = TextEditingController();

  bool isChecked = false;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  var filteredZones = List();
  List<BranchClass> filteredBranches = List();
  var filteredMembers = List();

  List<ZoneClass> zn = List<ZoneClass>();
  MemClass.MemberClass _memberClass = new MemClass.MemberClass();

  List<String> _marital = [
    'Married',
    'Single',
    'Divorced',
  ]; // Option 2
  String _selectedStatus;

  String groupValue = "Male";

  DateTime _date = new DateTime(2020);
  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());
    if (picked != null && picked != _date) {
      print('Date Selected: ${_date.toString()}');
      setState(() {
        _date = picked;

        var formatter = new DateFormat('yyyy-MM-dd');
        String formatted = formatter.format(_date);

        dobController.text = formatted.toString();
      });
    }
  }

  DateTime _datejoined = new DateTime(2020);
  Future<DateTime> _selectDatejoined(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _datejoined,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());
    if (picked != null && picked != _datejoined) {
      print('Date Selected: ${_datejoined.toString()}');
      setState(() {
        _datejoined = picked;

        var formatter = new DateFormat('yyyy-MM-dd');
        String formatted = formatter.format(_datewedding);

        datejoinedController.text = formatted.toString();
      });
    }
  }

  DateTime _datewedding = new DateTime(2020);
  Future<DateTime> _selectDatewedding(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _datewedding,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());
    if (picked != null && picked != _datewedding) {
      print('Date Selected: ${_datewedding.toString()}');
      setState(() {
        _datejoined = picked;

        var formatter = new DateFormat('yyyy-MM-dd');
        String formatted = formatter.format(_datewedding);

        anniversaryController.text = formatted.toString();
      });
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
  void initState() {
    super.initState();
    setState(() {
      zn = global.zones;
      filteredZones = zn;
      filteredBranches = global.branches;
      _memberClass = global.members;
      filteredMembers = _memberClass.members;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                        Padding(padding: EdgeInsets.only(left: 30)),
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
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            new SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: new Column(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Member Registration Form',
                            style: TextStyle(
                              fontFamily: 'Monserrati',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                                labelText: 'First Name',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            controller: middleNameController,
                            decoration: InputDecoration(
                                labelText: 'Middle Name',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            controller: surNameController,
                            decoration: InputDecoration(
                                labelText: 'Last Name',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              controller: datejoinedController,
                              decoration: InputDecoration(
                                  labelText: 'Date Joined',
                                  labelStyle: TextStyle(
                                      fontFamily: 'MontSerrat',
                                      fontWeight: FontWeight.bold)),
                              onTap: () {
                                _selectDatejoined(context);
                              },
                            ),
                          ),
                          SizedBox(height: 20.0),
                          DropdownButton(
                            hint: Text(
                                'Marital Status'), // Not necessary for Option 1
                            value: _selectedStatus,

                            onChanged: (newValue) {
                              setState(() {
                                _selectedStatus = newValue;
                              });
                            },
                            items: _marital.map((marital) {
                              return DropdownMenuItem(
                                child: new Text(marital),
                                value: marital,
                              );
                            }).toList(),
                            isExpanded: true,
                            style: TextStyle(
                                fontFamily: 'Monserrati',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black54),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: anniversaryController,
                                  decoration: InputDecoration(
                                      labelText: 'Wedding Anniversary',
                                      labelStyle: TextStyle(
                                          fontFamily: 'MontSerrat',
                                          fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    _selectDatewedding(context);
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: countryController,
                            decoration: InputDecoration(
                                labelText: 'Country',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: stateController,
                            decoration: InputDecoration(
                                labelText: 'State',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),

                          SizedBox(height: 20.0),
                          TextField(
                            controller: cityController,
                            decoration: InputDecoration(
                                labelText: 'City',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),

                          SizedBox(height: 30.0),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SearchableDropdown.single(
                                    items: filteredBranches
                                        .map((value) => DropdownMenuItem(
                                              child: Text(value.branchName),
                                              value: value.branchID,
                                            ))
                                        .toList(),
                                    onChanged: (int value) {
                                      setState(() {
                                        branchID = value;
                                        filteredZones = zn
                                            .where((u) =>
                                                (u.branch.branchId == branchID))
                                            .toList();
                                      });
                                    },
                                    isExpanded: false,
                                    hint: Text('Select  Branch'),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[],
                              ),
                            ],
                          ),

                          SizedBox(height: 20.0),
                          filteredBranches != null
                              ? Row(
                                  children: <Widget>[
                                    SearchableDropdown.single(
                                        hint: Text('Select Zone'),
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
                                          });
                                        }),
                                  ],
                                )
                              : Container(),

                          SizedBox(height: 20.0),
                          //_addSecondDropdown(),
                          filteredBranches != null
                              ? Row(
                                  children: <Widget>[
                                    SearchableDropdown.single(
                                        hint: Text('Invited By'),
                                        isExpanded: false,
                                        items: filteredMembers
                                            .where((u) =>
                                                (u.branch.branchId == branchID))
                                            .toList()
                                            .map((value) => DropdownMenuItem(
                                                  child: Text(value.firstName +
                                                      " " +
                                                      value.surName),
                                                  value: value.memberId,
                                                ))
                                            .toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            memberId = newValue;
                                          });
                                        }),
                                  ],
                                )
                              : Container(),

                          SizedBox(height: 20.0),
                          Row(
                            children: <Widget>[
                              Checkbox(
                                  value: isChecked,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isChecked = value;
                                    });
                                  }),
                              Text("Guest")
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              controller: dobController,
                              decoration: InputDecoration(
                                  labelText: 'DOB',
                                  labelStyle: TextStyle(
                                      fontFamily: 'MontSerrat',
                                      fontWeight: FontWeight.bold)),
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                          ),

                          SizedBox(height: 20.0),
                          TextField(
                            controller: noteController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            decoration: InputDecoration(
                                labelText: 'Notes',
                                labelStyle: TextStyle(
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.bold)),
                          ),

                          SizedBox(height: 30.0),
                          Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                Expanded(
                                    child: ListTile(
                                  title:
                                      Text('Male', textAlign: TextAlign.left),
                                  trailing: Radio(
                                      value: 'Male',
                                      groupValue: groupValue,
                                      onChanged: (e) => valueChanged(e)),
                                )),
                                Expanded(
                                    child: ListTile(
                                  title:
                                      Text('Female', textAlign: TextAlign.left),
                                  trailing: Radio(
                                      value: 'Female',
                                      groupValue: groupValue,
                                      onChanged: (e) => valueChanged(e)),
                                )),
                              ]),
                            ],
                          ),

                          SizedBox(height: 20.0),

                          GestureDetector(
                            onTap: (){
                               new Future.delayed(Duration.zero, () {
                                        loader('Saving Member...');

                                        MemberService.saveMembers(
                                                firstNameController.text,
                                                middleNameController.text,
                                                surNameController.text,
                                                addressController.text,
                                                cityController.text,
                                                countryController.text,
                                                stateController.text,
                                                phoneController.text,
                                                emailController.text,
                                                DateTime.parse(
                                                    dobController.text),
                                                groupValue,
                                                _selectedStatus,
                                                DateTime.parse(
                                                    anniversaryController.text),
                                                memberId,
                                                noteController.text,
                                                "Active",
                                                isChecked,
                                                DateTime.parse(
                                                    datejoinedController.text),
                                                'images/Male.jpg',
                                                branchID,
                                                zoneID)
                                            .then((responseFromServer) {
                                          setState(() {
                                            serverResponse = responseFromServer;
                                            if (serverResponse != null) {
                                              MemClass.Member memb =
                                                  new MemClass.Member();

                                              int id = serverResponse;
                                              memb.memberId = id;
                                              memb.firstName =
                                                  firstNameController.text;
                                              memb.middleName =
                                                  middleNameController.text;
                                              memb.surName =
                                                  surNameController.text;
                                              memb.address =
                                                  addressController.text;
                                              memb.city = cityController.text;
                                              memb.country =
                                                  countryController.text;
                                              memb.state = stateController.text;

                                              memb.phoneNumber =
                                                  phoneController.text;
                                              memb.emailAddress =
                                                  emailController.text;
                                              memb.dob = DateTime.parse(
                                                  dobController.text);
                                              memb.gender = groupValue;
                                              memb.maritalStatus =
                                                  _selectedStatus;
                                              memb.anniversary = DateTime.parse(
                                                  anniversaryController.text);
                                              memb.invitedBy = memberId;
                                              memb.note = noteController.text;
                                              memb.status = "Active";
                                              memb.guest = isChecked;
                                              memb.dateJoined = DateTime.parse(
                                                  datejoinedController.text);
                                              memb.pictureUrl = 'images/Male.jpg';

                                              MemClass.Branch br =
                                                  new MemClass.Branch();
                                              List<BranchClass> brL = global
                                                  .branches
                                                  .where((item) =>
                                                      item.branchID == branchID)
                                                  .toList();

                                              br.branchId = branchID;
                                              br.branchName = brL[0].branchName;
                                              br.city = brL[0].city;
                                              br.country = brL[0].country;
                                              br.parentId = brL[0].parentId;
                                              br.status = brL[0].status;

                                              memb.branch = br;

                                              MemClass.Zone z =
                                                  new MemClass.Zone();
                                              List<ZoneClass> zL = global.zones
                                                  .where((item) =>
                                                      item.zoneId == zoneID)
                                                  .toList();

                                              z.zoneId = zoneID;
                                              z.zoneName = zL[0].zoneName;
                                              z.adress = zL[0].adress;
                                              z.branch = br;

                                              memb.zone = z;
                                              global.members.members.add(memb);
                                              filteredZones = global.zones;
                                              Navigator.pop(context);
                                              dialog('Member Saved');
                                            }
                                          });
                                        });
                                      });

                            },
                            child: Container(
                              height: 40.0,
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.black,
                                  color: Colors.blue.shade900,
                                  elevation: 7.0,
                                  child: Center(
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'MontSerrat'),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ));
  }

  valueChanged(e) {
    setState(() {
      if (e == "Male") {
        groupValue = e;
      } else if (e == "Female") {
        groupValue = e;
      }
    });
  }

}
