import 'package:dcapp/screens/AppDrawer.dart';
import 'package:flutter/material.dart';

class TitheOffering extends StatefulWidget {
  @override
  _TitheOfferingState createState() => _TitheOfferingState();
}

class _TitheOfferingState extends State<TitheOffering> {
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
           
           Text ('Tithe and Offering',style: TextStyle(fontSize: 25, color: Colors.blue.shade900),),
          ]
        ),
         
        
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Tithe and Offering')
          ]
        ),
      ),
    );
  }
}