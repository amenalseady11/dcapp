import 'dart:core';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/screens/RoleActionList.dart';
import 'package:dcapp/screens/UpdateRole.dart';
import 'package:flutter/cupertino.dart';
import 'package:dcapp/classes/MemberRoleClass.dart' as role;
import 'package:flutter/material.dart';
import 'package:dcapp/services/RoleActionServe.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';



//import 'package:progress_indicators/progress_indicators.dart';


class RoleManagement extends StatefulWidget{
 // final int subId;
 
  @override
  _RoleManagement createState() => _RoleManagement();

}

class Debouncer{
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.milliseconds});

  run(VoidCallback action){
    if (null != _timer){
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

}
class _RoleManagement extends State<RoleManagement>{

  int deptID;
  int departmentId;
  String departmentName;
  
 var filteredMembers = List();
 
  List<role.Role> roleList = new List<role.Role>();
  List<role.Role> filteredrole = new List<role.Role>();
   
  

   var filteredDeptHeads  = List();
   var filteredDepts = List();

  @override
  void initState() {
    super.initState();
    setState(() {

    new Future.delayed(Duration.zero, () {
                  loader('Getting Roles...');
    
 RoleActionService.getRolesMember(global.profile.member.branch.branchId).then((roleFromServer) {
          setState(() {

            roleList = roleFromServer.roles;
            filteredrole= roleList;
            Navigator.pop(context);
          });
        });
   });
   });
  }
    
    int serverResponse;
    int branchID;
    int memberID;
    DateTime datePosted;
    String status;

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
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Role Management', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),
          actions: <Widget>[

            new IconButton(icon: new Icon(Icons.add,color: Colors.white,),onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context){
                                return UpdateRole();
                            }));}),

          ],
          backgroundColor: Colors.blue.shade900,

        ),
        body:
        Column(
          children: <Widget>[
           Card(
              elevation: 15.0,
              margin: EdgeInsets.only(top:0),
              child: Container(
                height: 150.0,
                color: Colors.blue.shade900,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text('Number of Members', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredrole.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                    ],),
                    SizedBox(height:30),
                     Container(
                       padding: EdgeInsets.only(left:20, right:20),
                       child: Material(
                          elevation: 7.0,
                        borderRadius: BorderRadius.circular(100.0),
                         child: TextField(
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Search Member...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredrole = roleList.where((u)=>
                    (u.members.firstName.toLowerCase().contains(string.toLowerCase())||
                
                    (u.members.surName.toLowerCase().contains(string.toLowerCase())

                    ||
                
                    (u.members.branch.branchName.toLowerCase().contains(string.toLowerCase())
                
                   )))).toList();
                    });


            },
            ),
                       ),
                     ),
                  
                    
                  ],
                ),
              ),),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredrole.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: (){
                        setState(() {
                         
                        });
                      },

                      child:  Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.only(left:18.0),
                               child: Column(
                                 
                                 children: <Widget>[
                                   Column(
                                     children: <Widget>[
                                       Row(
                                         children: <Widget>[
                                           Column(
                                             children: <Widget>[
                                               Text(filteredrole[index].members.firstName + " " + filteredrole[index].members.surName, 
                                               
                                               style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                   fontFamily: 'Monseratti'

                                               ),),
                                             ],
                                           ),
                                           
                                          
                                         ],
                                         
                                       ),
                                     ],
                                   ),
                                      
                                   Column(children:<Widget>[
                                     
                                   ])
                                 ],
                               ),
                              
                             ),
                             
                        SizedBox(height:2),
                                              
                              Row(
                                children: <Widget>[
                              
                                  SizedBox(width: 5),
                                Column(children:<Widget>[
                                  //Text(filteredDeptHeads[index].member.emailAddress),
                                ]),
                                 Spacer(),
                          Column(children:<Widget>[
                                  
                                  
                                 new RaisedButton(
                   color: Colors.blue,
                 child: new Text('Configure', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold),),
                 
                         onPressed: () {
                           global.roleaction =filteredrole[index].action;
                           global.memberRoleName = filteredrole[index].members.surName + " " + filteredrole[index].members.firstName;
                           global.roleMemberId = filteredrole[index].members.memberId;
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return RoleActionList();
                            }));
              },
         ),

                           ]),
           
                              ]
                              
                              
                              
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




