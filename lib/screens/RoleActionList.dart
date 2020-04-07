import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/services/RoleActionServe.dart';
import 'package:dcapp/classes/MemberRoleClass.dart'
    as roles;
import 'package:url_launcher/url_launcher.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:dcapp/classes/RoleActionClass.dart'
    as role;

class RoleActionList extends StatefulWidget {
  @override
  _RoleActionListState createState() => _RoleActionListState();
}

class _RoleActionListState extends State<RoleActionList> {
  int serverResponse;
  int branchID;
  int memberID;
  DateTime datePosted;
  String value;
  int roleId;

  List<role.Action> roleList = new List<role.Action>();

  List<roles.Role> memberRole = new List<roles.Role>();
  List<roles.Role> filteredrole = new List<roles.Role>();

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
  void initState() {
    super.initState();
    setState(() {
      new Future.delayed(Duration.zero, () {
        loader(' Loading My  Roles...');

         setState(() {
            filteredrole = global.roles;
          
          });

        RoleActionService.getRolesMemberbyMemberId(global.roleMemberId)
            .then((roleFromServer) {
          setState(() {
            filteredrole = roleFromServer.roles;
            //Navigator.pop(context);
          });
        });
      });

      RoleActionService.getRoleActions().then((roleFromServer) {
        setState(() {
          roleList = roleFromServer.actions;
            Navigator.pop(context);
        });
      });
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
            'Role Management',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                fontFamily: 'Monseratti',
                color: Colors.white),
          ),
          actions: <Widget>[],
          backgroundColor: Colors.blue.shade900,
        ),
        body: new Column(children: <Widget>[
          Card(
            elevation: 15.0,
            margin: EdgeInsets.only(top: 0),
            child: Container(
              height: 150.0,
              color: Colors.blue.shade900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text( getmemberPhone(memberId), style: TextStyle(color: Colors.white),),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        global.memberRoleName,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                      Widget>[
                    SearchableDropdown.single(
                        hint: Text('Select Role',
                            style: TextStyle(color: Colors.white)),
                        isExpanded: false,
                        items: roleList
                            .map((value) => DropdownMenuItem(
                                  child: Text(value.action),
                                  value: value.action,
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            value = newValue;
                          });
                        }),
                    new RaisedButton(
                        color: Colors.blue,
                        child: new Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          new Future.delayed(Duration.zero, () {
                            loader('Saving Role...');

                            RoleActionService.postAction(
                                    value,
                                    global.profile.member.branch.branchId,
                                    global.roleMemberId)
                                .then((responseFromServer) {
                              setState(() {
                                serverResponse = responseFromServer;
                                if (serverResponse != null) {
                                  RoleActionService.getRolesMemberbyMemberId(
                                          global.roleMemberId)
                                      .then((roleFromServer) {
                                    setState(() {
                                      filteredrole = roleFromServer.roles;
                                    });
                                    Navigator.pop(context);
                                  });
                                }

                                dialog('Role Saved');
                              });
                            });
                          });
                        }),
                  ])
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredrole.length,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                filteredrole[index].action,
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Monseratti'),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          new IconButton(
                                            padding: EdgeInsets.only(left: 0),
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              RoleActionService
                                                      .deleteMemberrole(
                                                          filteredrole[index].id)
                                                  .then((responseFromServer2) {
                                                
                                                  serverResponse =
                                                      responseFromServer2;
                                                  if (serverResponse != null) {
                                                    RoleActionService
                                                            .getRolesMemberbyMemberId(
                                                                global
                                                                    .roleMemberId)
                                                        .then((roleFromServer) {
                                                          setState(() {
                                                      filteredrole =
                                                          roleFromServer.roles;
                                                          });
                                                    });
                                                  }
                                               
                                              });
                                            },
                                          ),
                                          SizedBox(width: 20),
                                          Column(children: <Widget>[
                                            //Text(filteredrole[index].action)
                                          ])
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(children: <Widget>[])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ]));
  }
}
