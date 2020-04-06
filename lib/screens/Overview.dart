import 'package:dcapp/classes/BranchClass.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dcapp/classes/ProfileClass.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:intl/intl.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> with SingleTickerProviderStateMixin {

ProfileClass pr = ProfileClass();
 List<DeptDirectory> dept = List();
 DeptDirectory deptsD = new DeptDirectory();
 
    
  @override
  void initState() {
    super.initState();
     pr =global.profile;
     dept = global.profile.deptDirectory.toList();
     
     
  }


String parseDate(DateTime _date){
   var formatter = new DateFormat('yyyy-MM-dd');
        String formatted = formatter.format(_date);
      return formatted;
}
String getBranchName(int brID){
 List<BranchClass> br =  global.branches.where((u)=>u.branchID==brID).toList();
return br[0].branchName;
}


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: 
          Column(
            
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width-40,
                    child: Card(
                      elevation: 5,
                      
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding:  EdgeInsets.all(12.0),
                        child: Row(
                         
                          children: <Widget>[

                         Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Row(children: <Widget>[
                          Column(children: <Widget>[
                            //Icon
                            CircleAvatar(child: Icon(Icons.cake ) ,)
                          ],),
                          SizedBox(width:10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Row(children: <Widget>[
                              //Title
                              Text('Date of Birth', style: TextStyle(
                                fontSize: 15,
                               color: Colors.grey
                              ),)
                            ],),
                            Row(children: <Widget>[
                              //Value
                              Text(parseDate(global.profile.member.dob) , style: TextStyle(
                                fontSize: 16,
                                color:Colors.black ,
                                 fontWeight: FontWeight.bold,
                              ),)
                            ],)
                          ],)
                        ],),

                        SizedBox(height: 50),
                        Row(children: <Widget>[
                          Column(children: <Widget>[
                            //Icon
                            CircleAvatar(child: Icon(Icons.person ) ,)
                          ],),
                          SizedBox(width:10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Row(children: <Widget>[
                              //Title
                              Text('Gender', style: TextStyle(
                                fontSize: 15,
                               color: Colors.grey
                              ),)
                            ],),
                            Row(children: <Widget>[
                              //Value
                              Text(global.profile.member.gender , style: TextStyle(
                                fontSize: 16,
                                color:Colors.black ,
                                 fontWeight: FontWeight.bold,
                              ),)
                            ],)
                          ],)
                        ],),
                        SizedBox(height: 50),
                        Row(children: <Widget>[
                          Column(children: <Widget>[
                            //Icon
                            CircleAvatar(child: Icon(Icons.photo_library ) ,)
                          ],),
                          SizedBox(width:10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Row(children: <Widget>[
                              //Title
                              Text('Marital Status',  style: TextStyle(
                                fontSize: 15,
                               color: Colors.grey
                              ),)
                            ],),
                            Row(children: <Widget>[
                              //Value
                              Text(global.profile.member.maritalStatus , style: TextStyle(
                                fontSize: 16,
                                color:Colors.black ,
                                 fontWeight: FontWeight.bold,
                              ),)
                            ],)
                          ],)
                        ],)



                    ],),
                    SizedBox(width: 20),
                    //Second Column
                     Column(children: <Widget>[

                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Row(children: <Widget>[
                          Column(children: <Widget>[
                            //Icon
                            CircleAvatar(child: Icon(Icons.cake ) ,)
                          ],),
                          SizedBox(width:5),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Row(children: <Widget>[
                              //Title
                              Text('Anniversary', style: TextStyle(
                                fontSize: 15,
                               color: Colors.grey
                              ),)
                            ],),
                            Row(children: <Widget>[
                              //Value
                              Text(parseDate(global.profile.member.anniversary) , style: TextStyle(
                                fontSize: 16,
                                color:Colors.black ,
                                 fontWeight: FontWeight.bold,
                              ),)
                            ],)
                          ],)
                        ],),

                        SizedBox(height: 50),
                        Row(children: <Widget>[
                          Column(children: <Widget>[
                            //Icon
                            CircleAvatar(child: Icon(Icons.home ) ,)
                          ],),
                          SizedBox(width:10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Row(children: <Widget>[
                              //Title
                              Text('Branch', style: TextStyle(
                                fontSize: 15,
                               color: Colors.grey
                              ),)
                            ],),
                            Row(children: <Widget>[
                              //Value
                              Text(getBranchName(global.profile.member.branch.branchId) ,  style: TextStyle(
                                fontSize: 16,
                                color:Colors.black ,
                                 fontWeight: FontWeight.bold,
                              ),)
                            ],)
                          ],)
                        ],),
                        SizedBox(height: 50),
                        Row(children: <Widget>[
                          Column(children: <Widget>[
                            //Icon
                            CircleAvatar(child: Icon(Icons.home ) ,)
                          ],),
                          SizedBox(width:10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Row(children: <Widget>[
                              //Title
                              Text('Zone',  style: TextStyle(
                                fontSize: 15,
                               color: Colors.grey
                              ),)
                            ],),
                            Row(children: <Widget>[
                              //Value
                              Text(global.profile.member.zone.zoneName , style: TextStyle(
                                fontSize: 16,
                                color:Colors.black ,
                                 fontWeight: FontWeight.bold,
                              ),)
                            ],)
                          ],)
                        ],)



                    ],),

                    ],)
                 
                    ],),
                      ),),
                  )
                  //First Column
                 
                ],

                
              ),
              SizedBox(height:15),
               Card(
                elevation: 5,
                      
                margin: EdgeInsets.all(0),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                          Row(
                          
                            children:<Widget>[
                            //First Column
                            Column(children: <Widget>[
                              new IconButton
                              (
                                icon: Icon(Icons.call,color: Colors.black,),
                               onPressed: ()=> launch("tel:+${pr.member.phoneNumber.toString()}"),
                              ),
                              
                            ],),
                            //Second Column
                            SizedBox(width:20),
                             Column(
                               
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                               children: <Widget>[
                               Row(children: <Widget>[
                                 Text('Phone Number')

                               ],),
                                Row(children: <Widget>[
                                    Text(global.profile.member.phoneNumber, style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),)
                                 
                               ],)

                            ],),
                          ]),

                          SizedBox(height: 30),
                           Row(
                          
                            children:<Widget>[
                            //First Column
                            Column(children: <Widget>[
                              Column(children: <Widget>[
                              new IconButton
                              (
                                icon: Icon(Icons.mail,color: Colors.black,),
                               onPressed: ()=> launch("mailto:+${pr.member.emailAddress.toString()}"),
                              ),
                              
                            ],),
                            ],),
                            //Second Column
                            SizedBox(width:20),
                             Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                               children: <Widget>[
                               Row(children: <Widget>[
                                  

                                 Text('Email Address')

                               ],),
                                Row(children: <Widget>[
                                    Text(global.profile.member.emailAddress, style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),)
                                 
                               ],)

                            ],),
                          ]),

                           SizedBox(height: 30),
                           Row(
                          
                            children:<Widget>[
                            //First Column
                            Column(children: <Widget>[
                              Column(children: <Widget>[
                              IconButton
                              (
                                icon: Icon(Icons.home,color: Colors.black,),
                              
                              ),
                              
                            ],),
                            ],),
                            //Second Column
                            SizedBox(width:20),
                             Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                               children: <Widget>[
                               Row(children: <Widget>[
                                 Text('Home Address')

                               ],),
                                Row(children: <Widget>[
                                    Text(global.profile.member.address, style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),)
                                 
                               ],)

                            ],),
                          ])
                        
                    ],),
                  ),
                ),),
             
              SizedBox(height: 15),



              Card(
                elevation: 30,
                      
                margin: EdgeInsets.all(0),
                child: Container(
                  color: Colors.blue.shade900,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Text('Training Index', style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold),)
                    ],),
                    SizedBox(height:10),
                    Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Text(global.profile.trainingindex, style: TextStyle(color:Colors.white, fontSize:30, fontWeight: FontWeight.bold,),)
                    ],)
                    ],)
              ],),
                  ),
                ),),
             
            ],
          ),

          
        ) 
   
             
            ],
    );
  }

 

  getRatedStar(int rating, int index) {
    if (index <= rating) {
      return Icon(Icons.star, color: Colors.yellow[600]);
    } else {
      return Icon(Icons.star, color: Colors.grey);
    }
  }
}