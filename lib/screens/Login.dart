import 'package:dcapp/screens/Home.dart';
import 'package:dcapp/services/BranchHeadServ.dart';
import 'package:dcapp/services/DeptHeadServ.dart';
import 'package:dcapp/services/ProfileServ.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/screens/Details.dart';
import 'package:dcapp/screens/AppDrawer.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/services/RoleActionServe.dart';
import 'package:dcapp/services/ZoneHeadServ.dart';
import 'package:dcapp/services/deptServ.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Details> detailList;
  int count = 0;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  void performLogin() {
    final snackbar = new SnackBar(
      content: new Text("Email : $_email, password : $_password"),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
  //void _submit (){
  // final form = formKey.currentState;
  //if(form.validate()){
  //form.save();

  //performLogin();
  //}
  //}

  String _email;
  String _password;

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
  Widget build(BuildContext context) {
    if (detailList == null) {
      detailList = List<Details>();
    }
    return Scaffold(
        drawer: AppDrawer(),
        body: ListView(children: <Widget>[
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
                                    left:
                                        MediaQuery.of(context).size.width / 7)),
                            Image(
                                image: AssetImage("assets/domcitylogo2.jpg"),
                                width: MediaQuery.of(context).size.width / 7,
                                height: MediaQuery.of(context).size.width / 6),
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
                                    fontSize:
                                        MediaQuery.of(context).size.width / 11,
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
                                    fontSize:
                                        MediaQuery.of(context).size.width / 30,
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
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: usernameController,
                        decoration: new InputDecoration(
                          labelText: 'USERNAME',
                          labelStyle: TextStyle(
                              fontSize: 19,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        // validator: (val)=>
                        // !val.contains('@') ? 'Invalid Email' : null,
                        // onSaved: (val) => _email = val,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                    padding: EdgeInsets.only(
                      top: 35.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Column(children: <Widget>[
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontSize: 19,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                        obscureText: true,
                        //  validator: (val) => val.length < 6? "password does'nt match": null,
                        // onSaved: (val ) =>_password = val

                        // ,
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 20,
                            left: MediaQuery.of(context).size.width / 2),
                        child: InkWell(
                          child: Text(
                            'Forgot Password ',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          elevation: 12.0,
                          color: Colors.blue,
                          child: GestureDetector(
                            onTap: () {
                              //Authenticate Login from Server
                              new Future.delayed(Duration.zero, () {
                                loader('Authenticating....');

                                ProfileService.authenticate(
                                        usernameController.text,
                                        passwordController.text)
                                    .then((profileFromServer) {
                                  setState(() {
                                    global.profile = profileFromServer;
                                    if (global.profile.status == "Success") {
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
                                      Navigator.push(context,
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
                            },
                            child: Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]))
              ],
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
