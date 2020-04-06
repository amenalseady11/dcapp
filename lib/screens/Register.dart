
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.blue.shade900),
        elevation: 30.0,
        backgroundColor: Colors.white,
        title:
        new Row(
          children: <Widget>[
             SizedBox(width:25),
           
            SizedBox(width:20),
           
           Text ('Register',style: TextStyle(fontSize: 25, color: Colors.blue.shade900),),
          ]
        ),
         
        
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Register')
          ]
        ),
      ),
    );
  }
}