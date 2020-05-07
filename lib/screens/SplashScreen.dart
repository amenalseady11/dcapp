import 'package:dcapp/services/BranchHeadServ.dart';
import 'package:dcapp/services/DeptHeadServ.dart';
import 'package:dcapp/services/ProfileServ.dart';
import 'package:dcapp/services/RoleActionServe.dart';
import 'package:dcapp/services/ZoneHeadServ.dart';
import 'package:dcapp/services/branchServ.dart';
import 'package:dcapp/services/memberServ.dart';
import 'package:dcapp/services/zoneServ.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

String _email;
String _password;

class _SplashScreenState extends State<SplashScreen> {
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
                        },
                        child: Center(
                          child: Text(
                            'OK',
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

    SharedPreferences.getInstance().then((ss) {
      _email = ss.getString('Username');
      _password = ss.getString('Password');
    });

    new Future.delayed(Duration.zero, () async {
    var profileFromServer= await  ProfileService.authenticate(_email, _password);
        global.profile = profileFromServer;
        if (global.profile.status == "Success") {
         var roleFromServer = await RoleActionService.getRolesMemberbyMemberId(
                  profileFromServer.member.memberId);
              
            global.roles = roleFromServer.roles;

            BranchHeadService.checkifBranchHead(
                    profileFromServer.member.memberId)
                .then((response) {
              global.checkifbranchhead = response;
            });
            ZoneHeadService.checkifzone(profileFromServer.member.memberId)
                .then((response) {
              global.checkifzonehead = response;
            });
            DepartmentHeadService.checkifdepthead(
                    profileFromServer.member.memberId)
                .then((response) {
              global.checkifdepthhead = response.status;
              global.departmentheadDept = response.department;
            });
          

          BranchService.getBranches().then((branchesFromServer) {
            global.branches = branchesFromServer;
            global.branches.removeWhere((item) => item.branchName == null);
          });

          ZoneService.getZones().then((zonesFromServer) {
            global.zones = zonesFromServer;
            global.zones.removeWhere((item) => item.zoneName == null);
          });
          MemberService.getMembers().then((membersFromServer) {
            global.members = membersFromServer;
            global.members.members
                .removeWhere((item) => item.firstName == null);
            global.members.members.removeWhere((item) => item.surName == null);
            global.members.members
                .removeWhere((item) => item.branch.branchName == null);
            global.members.members
                .removeWhere((item) => item.zone.zoneName == null);
          });

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Home();
          }));
        } else {
          dialog("Authentication Error");
        }
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blue.shade900],
              ),
            ),
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 7)),
                        Image(
                            image: AssetImage("assets/domcitylogo2.jpg"),
                            width: MediaQuery.of(context).size.width / 7,
                            height: MediaQuery.of(context).size.width / 6),
                      ],
                    ),
                  ]),
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
                                      MediaQuery.of(context).size.width / 11,
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
                              '...raising leaders that transform society',
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
              SizedBox(height: 200),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
              SizedBox(height: 200),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Authenticating. Please wait...!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'OpenSans'))
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
