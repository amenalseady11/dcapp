import 'package:dcapp/classes/BranchClass.dart';
import 'package:dcapp/classes/SmsTemplateClass.dart' ;
import 'package:dcapp/screens/MembersRegistration.dart';
import 'package:dcapp/screens/SmsCreatingPage.dart';
import 'package:dcapp/services/SmsTemplateServe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/globals.dart' as global;


class SMS extends StatefulWidget {
  

  @override
  _SMS createState() => _SMS();
}

class _SMS extends State<SMS> {
 
  TextEditingController _smsTitletextFieldController = TextEditingController();
  TextEditingController _smsBodytextFieldController =
      TextEditingController();

 
  String smsTitle;
  String smsBody;
 
  int branchid;
  int zoneid;

  int serverResponse;
  List<SMsTemplate> smsT =  List();
 SmsTemplateClass memb = new SmsTemplateClass();
  var filteredsms = List();
  var filteredZones = List();
 

  List<BranchClass> filteredBranches = List();

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
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            'Back to List',
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

       setState(() {
 new Future.delayed(Duration.zero, () {
                  loader('Loading SMS Templates...');
     SmsTemplateService.getSmsTemplate().then((deptFromServer) {
        setState(() {
          memb = global.smsTemplateClass;
          global.smsTemplateClass = deptFromServer;
          global.smsTemplateClass.sMsTemplates.removeWhere((item) => item.smsTitle == null);
          smsT= global.smsTemplateClass.sMsTemplates;
         filteredsms = smsT;
          Navigator.pop(context);
        });
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
            'Manage  SMS Template',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                fontFamily: 'Monseratti',
                color: Colors.white),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                                return SmsCreate();
                            }));
              },
            ),
          ],
          backgroundColor: Colors.blue.shade900,
        ),
        body:    
        Column(
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
                          'Number of Templates',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          filteredsms.length.toString(),
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
                              hintText: 'Search SMS Templates...'),
                          onChanged: (string) {
                            setState(() {
                              filteredsms = smsT
                                  .where((u) => (u.smsTitle
                                          .toLowerCase()
                                          .contains(string.toLowerCase()) ||
                                      (u.sms.toLowerCase().contains(string.toLowerCase()) 
                                  )))
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
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredsms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {
                          _smsTitletextFieldController.text =
                              filteredsms[index].smsTitle;
                          _smsBodytextFieldController.text =filteredsms[index].sms;
                             
                        });
                      },
                      child: Card(
                        

                        child: Padding(
                          
                          padding: EdgeInsets.all(10.0),
                          
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           // crossAxisAlignment: CrossAxisAlignment.,
                            children: <Widget>[
                              Container(
                                child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(filteredsms[index].smsTitle , 
                                                style: TextStyle(
                                                     fontSize: 15.0,

                                                     fontWeight: FontWeight.bold,
                                                    fontFamily: 'Monseratti'
                                                ),),
                                              ],
                                            ),
                                           
                                          ],
                                      ),
                              ),
                                    SizedBox(height:15),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Text(filteredsms[index].sms , 
                                         style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                             fontFamily: 'Monseratti'

                                         ),),
                                       ],
                                     ),
                             
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        )
        
        );
  }
}
