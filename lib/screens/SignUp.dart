import 'dart:io';

import 'package:dcapp/classes/BranchClass.dart';
import 'package:dcapp/classes/RegistrationResponseClass.dart';
import 'package:dcapp/classes/zoneClass.dart';
import 'package:dcapp/screens/Home.dart';
import 'package:dcapp/services/BranchHeadServ.dart';
import 'package:dcapp/services/DeptHeadServ.dart';
import 'package:dcapp/services/ProfileServ.dart';
import 'package:connectivity/connectivity.dart';
import 'package:email_validator/email_validator.dart';
import 'package:dcapp/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/screens/Details.dart';
import 'package:dcapp/screens/AppDrawer.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/services/RoleActionServe.dart';
import 'package:dcapp/services/ZoneHeadServ.dart';
import 'package:dcapp/classes/memberClass.dart' as MemClass;
import 'package:dcapp/services/memberServ.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
  bool isChecked = false;
  String note;
  String status;
  String pictureURL;
  RegistrationresponseClass serverResponse;
  bool guest;
  DateTime dateJoined;
  String pictureUrl;
  int branchID;
  int zoneID;
  int memberId;
  bool formValid =true;

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

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();
  List<Details> detailList;
  int count = 0;
   
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

  String _email;
  String _password;
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
        String formatted = formatter.format(_datejoined);

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
        _datewedding = picked;

        var formatter = new DateFormat('yyyy-MM-dd');
        String formatted = formatter.format(_datewedding);

        anniversaryController.text = formatted.toString();
      });
    }
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
                            'OK',
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
  void initState() {
    super.initState();
      new Future.delayed(Duration.zero, () async {
      bool res = await checkconnectivity();
      if (!res) {
        dialog("Internet Required, Check your Network Connection");

        return;
      }
    setState(() {
      filteredBranches = global.branches;
       zn = global.zones;
      filteredZones = zn;
       _memberClass = global.members;
       filteredMembers = _memberClass.members;
    });
      });
  }


  @override
  Widget build(BuildContext context) {
    if (detailList == null) {
      detailList = List<Details>();
    }
    return Scaffold(
        drawer: AppDrawer(),
        body: ListView(
          shrinkWrap: true,
          
          children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom:40),
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blue.shade900],
              ),
            ),
           
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      )
                    ],
                  ),
                    SizedBox(height:15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   
                    children:<Widget>[
                    Text("Fields marked with (*) are mandatory fields", style:TextStyle(fontWeight: FontWeight.bold,color:Colors.red,fontSize:14))
                  ]),
                  SizedBox(height: 20.0),
                 
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                            Text(
                                '*',
                                style: TextStyle(fontWeight:FontWeight.bold, color:Colors.red,fontSize:18),
                              ),
                              Text(
                                'First Name',
                                style: kLabelStyle,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                              validator: (value) {
                                  if (value.isEmpty) {
                                    return "Fill Required Space";
                                  }
                                  return null;
                                },
                              controller: firstNameController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'First Name',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )),
                      SizedBox(height:10),
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Middle Name',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                              
                              controller: middleNameController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Middle Name',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )),

                      SizedBox(height:10),
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '*',
                                style: TextStyle(fontWeight:FontWeight.bold, color:Colors.red,fontSize:18),
                              ),
                              Text(
                                'Last Name',
                                style: kLabelStyle,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                               validator: (value) {
                                  if (value.isEmpty) {
                                    return "Fill Required Space";
                                  }
                                  return null;
                                },
                              controller: surNameController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Last Name',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )),

                      SizedBox(height:10),
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Gender',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
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
                      )),
                      SizedBox(height:10),
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '*',
                                style: TextStyle(fontWeight:FontWeight.bold, color:Colors.red,fontSize:18),
                              ),
                              Text(
                                'Date of Birth',
                                style: kLabelStyle,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                               validator: (value) {
                                  if (value.isEmpty) {
                                    return "Fill Required Space";
                                  }
                                  return null;
                                },
                              readOnly: true,
                              controller: dobController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.schedule,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Date of Birth',
                                hintStyle: kHintTextStyle,
                              ),
                               onTap: () {
                                   _selectDate(context);
                                },
                            ),
                          ),
                        ],
                      )),
                      SizedBox(height:10),
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Date Joined',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              readOnly: true,
                              controller: datejoinedController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.schedule,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Date Joined',
                                hintStyle: kHintTextStyle,
                              ),
                               onTap: () {
                                  _selectDatejoined(context);
                                },
                            ),
                          ),
                        ],
                      )),


                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Marital Status',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child:  DropdownButton(
                              
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
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black54),
                                  
                            ),

                          ),
                        ],
                      )),

                      SizedBox(height:10),
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Wedding Anniversary',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              readOnly: true,
                              controller: anniversaryController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.schedule,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Wedding Anniversary',
                                hintStyle: kHintTextStyle,
                              ),
                               onTap: () {
                                   _selectDatewedding(context);
                                },
                            ),
                          ),
                        ],
                      )),
                        SizedBox(height:10),
                         Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '*',
                                style: TextStyle(fontWeight:FontWeight.bold, color:Colors.red,fontSize:18),
                              ),
                              Text(
                                'Email',
                                style: kLabelStyle,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                              validator: (value) {
                              final bool isValid = EmailValidator.validate(value);
                                if(!isValid){
                               return "Enter a valid Email";
                               }
                                  return null;
                                },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Enter your Email',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )),
                       SizedBox(height:10),
                         Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '*',
                                style: TextStyle(fontWeight:FontWeight.bold, color:Colors.red,fontSize:18),
                              ),
                              Text(
                                'Phone Number',
                                style: kLabelStyle,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                               validator: (value) {
                                  if (value.isEmpty) {
                                    return "Fill Required Space";
                                  }
                                  return null;
                                },
                              controller: phoneController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Phone Number',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )),
                      SizedBox(height:10),
                         Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Address',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: addressController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Address',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )),
                       SizedBox(height:10),
                         Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Country',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: countryController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Country',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )),
                      SizedBox(height:10),
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'State',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: stateController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'State',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )),
                      SizedBox(height:10),
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '*',
                                style: TextStyle(fontWeight:FontWeight.bold, color:Colors.red,fontSize:18),
                              ),
                              Text(
                                'Select Branch',
                                style: kLabelStyle,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            
                            height: 68.0,
                            child:  
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
                          ),
                        ],
                      )),
                       filteredBranches != null
                                ? 
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '*',
                                style: TextStyle(fontWeight:FontWeight.bold, color:Colors.red,fontSize:18),
                              ),
                              Text(
                                'Select Zone',
                                style: kLabelStyle,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 68.0,
                            child:  
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
                          ),
                        ],
                      ))
                      : Container(),

                      SizedBox(height:10),
                        filteredBranches != null
                                ?
                       Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Invited By',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 68.0,
                            child:  
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
                          ),
                        ],
                      ))
                      : Container(),
                  SizedBox(height: 10.0),
                   Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Guest ?',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 68.0,
                            child:  
                            Checkbox(
                                    value: isChecked,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isChecked = value;
                                      });
                                    }),
                          ),
                        ],
                      )),
                      
                 
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(formValid? '': 'Please fill all mandatory field', style: TextStyle(color:Colors.red,fontWeight:FontWeight.bold),),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () async {
                         bool res = await checkconnectivity();
                        if (!res) {
                         dialog("Internet Required, Check your Network Connection");
                          return;
                           }
                        if (_formKey.currentState.validate()){
                          if(branchID==null || zoneID== null){
                            setState(() {
                               formValid=false;
                            });
                            dialog("Please Select Branch and Zone");
                            return;
                          }
                          setState(() {
                             formValid=true;
                          });
                         
                        //Authenticate Login from Server
                        new Future.delayed(Duration.zero, () {
                          loader('Creating Account....');
                                     MemberService.signUp(
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
                                                    anniversaryController.text==""?DateTime.now().toString():anniversaryController.text ),
                                                memberId,
                                                noteController.text,
                                                "Active",
                                                isChecked,
                                                DateTime.parse(
                                                    datejoinedController.text==""? DateTime.now().toString():datejoinedController.text),
                                                'images/Male.jpg',
                                                branchID,
                                                zoneID)
                                            .then((responseFromServer) {
                                          setState(() {
                                            serverResponse = responseFromServer;
                                            if (serverResponse.id >0) {
                                             
                                              Navigator.pop(context);
                                              dialog('Registration Successful');

                                              var username=  serverResponse.registrationResponse.email;
                                              var password = serverResponse.registrationResponse.password;

                                              Navigator.pop(context);
                                               new Future.delayed(Duration.zero, () {
                            loader('Authenticating....');

                            ProfileService.authenticate(
                                    username,
                                    password)
                                .then((profileFromServer) {
                              setState(() {
                                global.profile = profileFromServer;
                                if (global.profile.status == "Success") {
                                   SharedPreferences.getInstance().then((ss) {
                                    ss.setString(
                                        'Username', username);
                                    ss.setString(
                                        "Password", password);
                                  });
                                  RoleActionService
                                          .getRolesMemberbyMemberId(
                                              profileFromServer
                                                  .member.memberId)
                                      .then((roleFromServer) {
                                    setState(() {
                                      global.roles = roleFromServer.roles;
                                      
                                  
                                    });

                                      BranchHeadService.checkifBranchHead(profileFromServer
                                                  .member.memberId)
                                      .then((response) {
                                           global.checkifbranchhead = response;
                                           

                                      });
                                        ZoneHeadService.checkifzone(profileFromServer
                                                  .member.memberId)
                                      .then((response) {
                                           global.checkifzonehead = response;

                                      });
                                      DepartmentHeadService.checkifdepthead(profileFromServer
                                                  .member.memberId)
                                      .then((response) {
                                           global.checkifdepthhead = response.status;
                                             global.departmentheadDept = response.department;
                                      });
                                  });
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                                } else {
                                  dialog("Invalid Login Credentials");
                                  Navigator.pop(context);
                                }
                              });
                               });
                                });
                                            }
                                          });
                                        });
                         
                        });
                      }else{
                         setState(() {
                               formValid=false;
                            });
                      }
                      },
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF527DAA),
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                    ],
                  ),
                 
                ],
              ),
            ),
            
            
          ),
          Container()
        ]));
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
