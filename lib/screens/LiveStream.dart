import 'package:dcapp/screens/AppDrawer.dart';
import 'package:flutter/material.dart';

class LiveStream extends StatefulWidget {
  @override
  _LiveStreamState createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
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
           
           Text ('Live Stream',style: TextStyle(fontSize: 25, color: Colors.blue.shade900),),
          ]
        ),
         
        
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('')
          ]
        ),
      ),
    );
  }
}