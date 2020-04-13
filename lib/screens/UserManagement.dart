import 'package:flutter/material.dart';
import 'package:dcapp/classes/UsersClass.dart' as user;
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/services/UserServ.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Usermanagement extends StatefulWidget {
  @override
  _UsermanagementState createState() => new _UsermanagementState();
}

class _UsermanagementState extends State<Usermanagement> {
  // List<news.News> _news = List<news.News>();
  // List<news.News> filteredNews = List<news.News>();

  List<user.User> _user = List<user.User>();
  List<user.User> filtereduser = List<user.User>();

  int count = 0;
  String position;

  @override
  void initState() {
    super.initState();
    setState(() {
      new Future.delayed(Duration.zero, () {
        loader(' Loading  Users ...');

        UserService.getUser(global.profile.member.branch.branchId)
            .then((userFromServer) {
          setState(() {
            _user = userFromServer.users;
            _user.removeWhere((item) => item.member.firstName == null);
            _user.removeWhere((item) => item.member.surName == null);

            filtereduser = _user;

            Navigator.pop(context);
          });
        });
      });
    });
  }

 
  getPosition(String position, int id, int index){
      if(position == "Member"){
        return RaisedButton(
          color: Colors.blue,
          child: Text("Set to Pastor", style: TextStyle(color:Colors.white),),
          onPressed: (){
            updatePosition(id, index, "Pastor");

          },
          );

      }
      else{
        return RaisedButton(
          color: Colors.blue,
          child: Text("Set to  Member",style: TextStyle(color:Colors.white)),
           onPressed: () {
                  updatePosition(id, index, "Member");
                },
          );}
  }

  updatePosition(int id, int index, String position){
UserService.updateUserPosition(id, position).then((userfromServer){
  if(userfromServer== 200){
    setState(() {
       filtereduser[index].position=position;
    });
   
  }

});

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
                              left: 2)),
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
                        'Number ofUsers',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        filtereduser.length.toString(),
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
                            hintText: 'Search Users...'),
                        onChanged: (string) {
                          setState(() {
                            filtereduser = _user
                                .where((u) => (u.member.surName
                                        .toString()
                                        .toLowerCase()
                                        .contains(string.toLowerCase()) ||
                                    (u.member.firstName
                                            .toLowerCase()
                                            .contains(string.toLowerCase()) ||
                                        (u.position
                                            .toString()
                                            .toLowerCase()
                                            .contains(string.toLowerCase())))))
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
                padding: EdgeInsets.all(0.0),
                itemCount: filtereduser.length,
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
                              Container(
                                width: 250,
                                child: Column(
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
                                                        filtereduser[index]
                                                                .member
                                                                .firstName +
                                                            " " +
                                                            filtereduser[index]
                                                                .member
                                                                .surName,
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Monseratti'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child:
                                              Text(filtereduser[index].userName),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          "(" +
                                              filtereduser[index].position +
                                              ")",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ])
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(children: <Widget>[
                                getPosition(filtereduser[index].position, filtereduser[index].id, index),
                                Row(
                                  children: <Widget>[
                                    // Text( filteredDisciple[index])
                                  ],
                                ),
                              ])
                            ],
                          ),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
