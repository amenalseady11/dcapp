
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:dcapp/services/SMSServe.dart';
import 'package:progress_indicators/progress_indicators.dart';


class MVPMessage extends StatefulWidget {
  @override
  _MVPMessageState createState() => _MVPMessageState();
}

class _MVPMessageState extends State<MVPMessage> {


final List<String> categories = ["All ", 
 "Today", 
  "This Week", 
  "This Month",
 "This Year", 
 "2 Months Old",
    "3 Months Old",
    "6 Months Old",
   
   ];


  List<String> filteredsms = List();

TextEditingController  _smsController = new TextEditingController();

String sms;
String deptName;
String subcategory;
  var filteredDepts = List();



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
        GestureDetector(
            onTap: (){
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
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                          )
                      ),

                    ),
        ),
        ],) 
        
      ));
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
                                  child: new Text('...raising leaders that transform society',style:TextStyle(fontSize: 8, fontWeight: FontWeight.bold,color: Colors.indigo),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
        ]
        ),
        backgroundColor: Colors.white,
),
body: Column(
children: <Widget>[

Padding(
  padding: const EdgeInsets.only(top:50.0, left: 20, right: 20),
  child:  Container(
  margin: EdgeInsets.all(8.0),
  
  padding: EdgeInsets.only(bottom: 40.0),
  child: Column(
    children: <Widget>[
       SearchableDropdown.single(
                          
                        hint: Text('Select MVP Category'), // Not necessary for Option 1
                       // value: filteredsms,
                      
                        onChanged: (newValue) {
                        setState(() {
                       subcategory = newValue;
                        });
                        },
                      items: categories.map((subcat) {
                        return DropdownMenuItem(
                      child: new Text(subcat),
                      value: subcat,
                      
                       );
                       }).toList(),
                        isExpanded: true,
                        style: TextStyle(
                          fontFamily: 'Monserrati',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black54
                        ),
                        ),

SizedBox(height:15),

      TextField(
        controller: _smsController,
        maxLines: 10,
        maxLength: 160,
        decoration: InputDecoration(
            hintText: "Message!",
            border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height:2),
       Padding(
         padding: const EdgeInsets.only(left:180.0),
         child: new RaisedButton(
                 color: Colors.blue.shade900,
                child: new Text("Send", style: TextStyle(color: Colors.white),),
                onPressed: () {
                    new Future.delayed(Duration.zero, () {
                  loader('Sending SMS...');

                 
               
                      SMSService.sendSms(global.profile.member.branch.branchId, _smsController.text, global.selectedCategory, subcategory).then((responseFromServer) {
                    setState(() {
                    
                    Navigator.pop(context);

                    if(responseFromServer>0){
                          dialog('Message sent successfully to ' + responseFromServer.toString() +' receipients');
                    }else{
                        dialog('No Receipient found for the selected category');
                    }
                  

                    });
                   });
                    
                 });
                },
              ),
       ),
    ],
  ),
),
                  
),

],







  
),




      
    );
  }
}