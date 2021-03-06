

import 'package:flutter/material.dart';

class AccessDenied extends StatefulWidget {
  @override
  _AccessDeniedState createState() => _AccessDeniedState();
}

class _AccessDeniedState extends State<AccessDenied> {
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
              SizedBox(height: 200),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                
                ],
              ),
              SizedBox(height: 200),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('ACCESS DENIED',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 30,
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