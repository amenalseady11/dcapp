import 'package:dcapp/screens/Home.dart';
import 'package:dcapp/screens/SignUp.dart';
import 'package:dcapp/screens/SplashScreen.dart';
import 'package:dcapp/services/BranchHeadServ.dart';
import 'package:dcapp/services/DeptHeadServ.dart';
import 'package:dcapp/services/ProfileServ.dart';
import 'package:dcapp/services/branchServ.dart';
import 'package:dcapp/services/memberServ.dart';
import 'package:dcapp/services/zoneServ.dart';
import 'package:dcapp/utilities/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/screens/Details.dart';
import 'package:dcapp/screens/AppDrawer.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/services/RoleActionServe.dart';
import 'package:dcapp/services/ZoneHeadServ.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:io';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Details> detailList;
  int count = 0;

  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

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

      SharedPreferences.getInstance().then((ss) {
        _email = ss.getString('Username') ?? 'null';
        _password = ss.getString('Password') ?? 'null';

        if (_email != "null" || _password != "null") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return SplashScreen();
          }));
        } else {
          _email = "";
          _password = "";
        }
      });

      BranchService.getBranches().then((branchesFromServer) {
        setState(() {
          global.branches = branchesFromServer;
          global.branches.removeWhere((item) => item.branchName == null);
        });
      });

      ZoneService.getZones().then((zonesFromServer) {
        setState(() {
          global.zones = zonesFromServer;
          global.zones.removeWhere((item) => item.zoneName == null);
        });
      });
      MemberService.getMembers().then((membersFromServer) {
        setState(() {
          global.members = membersFromServer;
          global.members.members.removeWhere((item) => item.firstName == null);
          global.members.members.removeWhere((item) => item.surName == null);
          global.members.members
              .removeWhere((item) => item.branch.branchName == null);
          global.members.members
              .removeWhere((item) => item.zone.zoneName == null);
        });
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
        body: ListView(shrinkWrap: true, physics: ScrollPhysics(), children: <
            Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blue.shade900],
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          7)),
                              Image(
                                  image: AssetImage("assets/domcitylogo2.jpg"),
                                  width: MediaQuery.of(context).size.width / 7,
                                  height:
                                      MediaQuery.of(context).size.width / 6),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 25),
                                child: new Text(
                                  'Dominion City',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              11,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                      color: Colors.indigo),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                child: new Text(
                                  '...raising leaders that transforms society',
                                  style: TextStyle(
                                      fontSize: 11,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Username or Email',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 50.0,
                            child: TextFormField(
                              validator: (value) {
                                final bool isValid =
                                    EmailValidator.validate(value);
                                if (!isValid) {
                                  return "Enter a valid Email";
                                }
                                return null;
                              },
                              controller: usernameController,
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
                            'Password',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 50.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please Enter Password";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: passwordController,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.blue.shade900,
                                ),
                                hintText: 'Enter Password',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 3.0),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 20,
                        left: MediaQuery.of(context).size.width / 2),
                    child: InkWell(
                      child: Text(
                        'Forgot Password ',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: ()async {
                         bool res = await checkconnectivity();
                        if (!res) {
                         dialog("Internet Required, Check your Network Connection");
                          return;
                           }
                        if (_formKey.currentState.validate()) {
                          //Authenticate Login from Server
                          new Future.delayed(Duration.zero, () {
                            loader('Authenticating....');

                            ProfileService.authenticate(usernameController.text,
                                    passwordController.text)
                                .then((profileFromServer) {
                              setState(() {
                                global.profile = profileFromServer;
                                if (global.profile.status == "Success") {
                                  SharedPreferences.getInstance().then((ss) {
                                    ss.setString(
                                        'Username', usernameController.text);
                                    ss.setString(
                                        "Password", passwordController.text);
                                  });

                                  RoleActionService.getRolesMemberbyMemberId(
                                          profileFromServer.member.memberId)
                                      .then((roleFromServer) {
                                    setState(() {
                                      global.roles = roleFromServer.roles;
                                    });

                                    BranchHeadService.checkifBranchHead(
                                            profileFromServer.member.memberId)
                                        .then((response) {
                                      global.checkifbranchhead = response;
                                    });
                                    ZoneHeadService.checkifzone(
                                            profileFromServer.member.memberId)
                                        .then((response) {
                                      global.checkifzonehead = response;
                                    });
                                    DepartmentHeadService.checkifdepthead(
                                            profileFromServer.member.memberId)
                                        .then((response) {
                                      global.checkifdepthhead = response.status;
                                      global.departmentheadDept =
                                          response.department;
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
                      },
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        'LOGIN',
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
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUp();
                          }));
                        },
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Can't Sign in?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "CONTACT US",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]));
  }

//void _delete (BuildContext context, Details  details) async{

  //  int result = await databaseHelper.deleteDetails(details.id);
  //if(result !=0){
  //_showSnackbar(context, 'Contact Deleted');
  //}
//}

//void _showSnackbar(BuildContext context, String message){
  //  final snackbar = SnackBar(content: Text(message),);
  //Scaffold.of(context).showSnackBar(snackbar);

}
