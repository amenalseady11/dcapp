import 'package:dcapp/classes/BranchClass.dart';
import 'package:dcapp/services/AttendanceServ.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/classes/AttendaceClass.dart';
import 'package:dcapp/classes/AttendanceClass2.dart' as currentAttendance;
import 'package:progress_indicators/progress_indicators.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

var filteredAttendance = List();
bool isChecked =false;
List<AttendanceClass> attendance = new List<AttendanceClass>();
currentAttendance.AttendanceClass2 att = new currentAttendance.AttendanceClass2();

  @override
  void initState() {
    super.initState();
    setState(() {
   
    //
        new Future.delayed(Duration.zero, () {
                  loader('Loading Todays Attendance...');
     AttendanceService.getAttendance(global.profile.member.branch.branchId, DateTime.now()).then((attendanceFromServer) {
        setState(() {
          att = attendanceFromServer;
         
           global.members.members.forEach((item){
     AttendanceClass tempAttendance = new AttendanceClass();
     tempAttendance.memberid = item.memberId;
     tempAttendance.name = item.firstName +' '+ item.surName +' ' + item.middleName;
     tempAttendance.branch = item.branch.branchName;
     tempAttendance.zone = item.zone.zoneName;

     //Check if the current member is already checked in at the current date 
      tempAttendance.selected =checkIfExists(item.memberId);

      tempAttendance.branchid = item.branch.branchId;
      tempAttendance.zoneid = item.zone.zoneId;

      attendance.add(tempAttendance);
   });
    filteredAttendance = attendance;
    
         Navigator.pop(context);
        });
      });
     });
    
   

 
   });
  }

  bool checkIfExists(int memberId){

   List<currentAttendance.Attendance> tempatt = att.attendances.where((u)=> u.member.memberId==memberId && (u.dateEntered.day==DateTime.now().day && u.dateEntered.month==DateTime.now().month && u.dateEntered.year==DateTime.now().year)).toList();
  // print  (tempatt[0].dateEntered.toString());

   
    if(tempatt.length==0) {
      return false;
    }else{
      return true;
    }
  }


 Future<bool> loader(String str){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText(str,style: TextStyle(fontSize:12),),
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
                      Padding(padding: EdgeInsets.only(left: 2)),
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
                              fontSize: 9,
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
        ]
        ),
        backgroundColor: Colors.white,
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

                      Text(filteredAttendance.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Members...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredAttendance = attendance.where((u)=>
                    (u.branch.toLowerCase().contains(string.toLowerCase())||
                
                    (u.name.toLowerCase().contains(string.toLowerCase())

                    ||
                
                    (u.zone.toLowerCase().contains(string.toLowerCase())
                
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
                  itemCount: filteredAttendance.length,
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
                                               Text(filteredAttendance[index].name, 
                                               style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   fontFamily: 'Monseratti'

                                               ),),
                                             ],
                                           ),
                                          
                                          
                                         ],
                                         
                                       ),
                                        SizedBox(height: 20),
                                     ],
                                   ),
                                   Row(
                                     children:<Widget>[
                                      Column(
                                       
                                        children: <Widget>[
                                          Text(filteredAttendance[index].branch + ","+ filteredAttendance[index].zone, style: TextStyle(fontSize:10), ),
                                        ],
                                      ),
                                          
                                           Spacer(),
                                            Column(
                                              children: <Widget>[
                                                Checkbox(value: filteredAttendance[index].selected, 
                                             onChanged: (bool value){
                                              setState(() {
                                            filteredAttendance[index].selected = value;

                                            //Send Changes to Server
                                           
                                                   AttendanceService.saveAttendance(filteredAttendance[index].memberid, filteredAttendance[index].branchid, filteredAttendance[index].zoneid,  DateTime.now(), value).then((attendanceFromServer) {
                                                    setState(() {
                                                       if(attendanceFromServer == 'Success'){
//Checked In Successfully                               
                                          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Checked In Successfully'),));
                                                       
                                                       }
                                                      else if(attendanceFromServer=='Deleted'){
                                                       Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Checked In Removed'),));
                                                      }else{
                                                           Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Error Checking In'),));
//Error checking in
                                                      }
                                                   });
        
                                              });
    
                                         });
                                           }),
                                              ],
                                            ),
                                        Text("Check In")
                                           ]
                                   )
                                 ],
                               ),
                              
                             ),
                            ],
                          ),
                        ),
                      )
                      ,
                    );

                  }),
            )
          ],
        )
        








    );
  }
}