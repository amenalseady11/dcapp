

import 'package:dcapp/classes/smsTemplateClass.dart' as sms;
import 'package:dcapp/services/SmsTemplateServe.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/classes/BranchClass.dart';
import 'package:dcapp/classes/zoneClass.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;




class SmsCreate extends StatefulWidget{
  _SmsCreate createState()=> _SmsCreate();

}


class _SmsCreate extends State<SmsCreate> {
    String smsTitle;
    String smsBody;
   int serverResponse;
    int branchID;
    int zoneId;
    

  
  
TextEditingController smsTitleController =  TextEditingController();
TextEditingController smsBodyController =  TextEditingController();

// List <sms.SMsTemplate> smsT = List <sms.SMsTemplate>();
 
  var filteredsms = List();
  
  sms.SmsTemplateClass _smsClass = new sms.SmsTemplateClass();
 List<ZoneClass> fiilteredzone = List<ZoneClass>();

  List<BranchClass> filteredBranches = List();



Future<bool> loader(String str){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText(str),
        ));
  }


Future<bool> dialog(str){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title:Text('Message') ,
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(str, style: TextStyle(
          fontSize: 14,
          color: Colors.blue.shade900

        ),),
        SizedBox(height: 10.0,),
        Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blue.shade900,
                        color: Colors.blue.shade900,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){
                             Navigator.pop(context);
                             Navigator.pop(context);
                             
                          },
                          child: Center(
                            child: Text(
                              'Back to List',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                          ),
                        )
                    ),

                  ),
        ],) 
        
      ));
    }

    @override
   void initState() {

    super.initState();
    filteredBranches=global.branches;
    fiilteredzone = global.zones;
    
        setState(() {
         // filteredZones = global.zones;
         SmsTemplateService.getSmsTemplate().then((deptFromServer) {
         
          global.smsTemplateClass = deptFromServer;
          global.smsTemplateClass.sMsTemplates.removeWhere((item) => item.smsTitle == null);
          _smsClass = global.smsTemplateClass.sMsTemplates as sms.SmsTemplateClass;
          filteredsms = _smsClass.sMsTemplates;
        
        });
      });

     
   }

 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.blue.shade900),
        elevation: 15.0,

        title:Column(children:<Widget>[
             Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[

                            Row(
                              
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left:30)),
                                Image(image: AssetImage("assets/domcitylogo2.jpg"), width: 50,height: 50),
                               
                              ],
                            ),
                          ],
                        ),
                        Column(
                         
                          children: <Widget>[
                            
                            Row(
                              
                              children: <Widget>[
                               
                                Container(
                                  padding: EdgeInsets.only(top:80),
                                  
                                  
                                  child: new Text('Dominion City',style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.indigo),),
                                ),
                              ],
                            ),
                             Row(
                              
                              children: <Widget>[
                                Container(
                                 
                                  height: 100.0,
                                  
                                  child: new Text('...raising leaders that transforms society',style:TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.indigo),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

        ]),
        
        backgroundColor: Colors.white,

),
        body: 
       ListView(
         children: <Widget>[
           new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: new Column(
              children: <Widget>[
                 
                Container(
                  padding: EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[

                      Text('Create SMS Template', style: TextStyle(
                        fontFamily: 'Monserrati',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        
                      ),),
                      SizedBox(height: 40,),
                      TextField(
                        controller: smsTitleController,
                        decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle:  TextStyle(
                                fontFamily: 'MontSerrat',
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                       SizedBox(height: 40,),
                      TextField(
                        controller: smsBodyController,
                        decoration: InputDecoration(
                            labelText: 'Body',
                            labelStyle:  TextStyle(
                                fontFamily: 'MontSerrat',
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                           SizedBox(height: 30.0),
                        Column(
                        
                          children: <Widget>[
                            Row(
                              
                              children: <Widget>[
                                
                                SearchableDropdown.single(
                                   
                  
                  items: filteredBranches
                      .map((value) => DropdownMenuItem(
                        
                                    child: Text(value.branchName),
                                    value: value.branchID,
                                  ))
                      .toList(),
                  onChanged: (newValue) {
                   branchID = newValue;
                  },

                  isExpanded: false,
                  hint: Text('Select  Branch'),
                  
                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[],
                            ),
                          ],
                        ),

                         SizedBox(height: 20.0),
                     
                      filteredBranches != null
                      ?
                        
                        Row(
                          children: <Widget>[
                            SearchableDropdown.single(
                   hint: Text('Select Zone'),
                    isExpanded: false,
                  items: fiilteredzone
                      .map((value) => DropdownMenuItem(
                                child: Text(value.zoneName),
                                value: value.zoneId,
                              ))
                      .toList(),
                      
                  onChanged: (newValue) {
              setState(() {
                zoneId = newValue;
              });
            }
                ),
                          ],
                        ): Container(),

                           SizedBox(height: 20.0),
                      SizedBox(height: 20.0),
                      
                      Container(
                        height: 40.0,
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.black,
                            color: Colors.blue.shade900,
                            elevation: 7.0,
                            child: GestureDetector(
                             onTap: () {

                //save to server
                 new Future.delayed(Duration.zero, () {
                  loader('Saving SMS Templates...');

                    SmsTemplateService.saveSmsTemplate(branchID,zoneId,smsTitleController.text, smsBodyController.text, ).then((responseFromServer) {
                    setState(() {
                      
                    serverResponse = responseFromServer;
                   if(serverResponse !=null){
                 SmsTemplateService.getSmsTemplate().then((deptFromServer) {
         
          global.smsTemplateClass = deptFromServer;
          global.smsTemplateClass.sMsTemplates.removeWhere((item) => item.smsTitle == null);
          _smsClass = global.smsTemplateClass.sMsTemplates as sms.SmsTemplateClass;
          filteredsms = _smsClass.sMsTemplates;
        
        });
      
                    
                     Navigator.pop(context);
                    dialog('Template Saved');

                   }
                        
                    });
                    
                   });
                    
                 });
                   
              
              },
                              child: Center(
                                
                                child: Text(
                                  'CREATE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'MontSerrat'
                                  ),
                                ),
                                
                              ),
                              
                            )
                        ),

                      ),
                    
                    
                    ],
                  ),

                )
              ],
            )
              
            ),
         ],
       )
  
    );
  
  
  
  
  
 } }
  




 



