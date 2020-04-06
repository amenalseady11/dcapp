
// import 'package:flutter_zoom_plugin_example/services/MeetingServ.dart' ;
// import 'package:flutter_zoom_plugin_example/classes/MeetingClass.dart'as meet;

// import 'package:flutter/material.dart';
// import 'package:progress_indicators/progress_indicators.dart';
// import 'package:flutter_zoom_plugin_example/globals.dart' as global;

// import 'package:intl/intl.dart';


// class CreateMeeting extends StatefulWidget {
//   @override
//   _CreateMeetingState createState() => _CreateMeetingState();
// }

// class _CreateMeetingState extends State<CreateMeeting> {



    
// List<meet.Meeting> _meetings = List<meet.Meeting>();
// List<meet.Meeting> filteredMeeting = List<meet.Meeting>();

//   int serverresponse;

// TextEditingController  _meetingTitleController = new TextEditingController();
// TextEditingController  _meetingIDeController = new TextEditingController();
// TextEditingController  _meetingPasswordController = new TextEditingController();
// TextEditingController  _meetingTimeController = new TextEditingController();
// TextEditingController  _meetingDateeController = new TextEditingController();

// String sms;
//  final List<String> categories = ["All Members", 
//  "All Males", 
//   "All Females", 
//   "All Zonal Leaders",
//  "All Workers", 
//  "Department Head",
//  "All Pastors",
   
//    ]; 
//    String _selectedCategories;

//  DateTime _eventsdate = new DateTime(2020);
//   Future<DateTime> _selectMeetingDate(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: _eventsdate,
//         firstDate: new DateTime(1900),
//         lastDate: new DateTime(2099));
//     if (picked != null && picked != _eventsdate) {
//       setState(() {
//         _eventsdate = picked;

//         var formatter = new DateFormat('yyyy-MM-dd');
//         String formatted = formatter.format(_eventsdate);

//         _meetingDateeController.text = formatted.toString();
//       });
//     }
//   }
  

//   TimeOfDay _time = new TimeOfDay.now();

//   Future<Null> _meetingTime(BuildContext context) async {
//      TimeOfDay picked = await showTimePicker(
//       context: context,
//       initialTime: _time,
//     );

//     if (picked != null && picked != _time) {
//       // print('Time selected: ${_time.toString()}');
//       setState(() {
//         _time = picked;
//         _meetingTimeController.text = _time.format(context);
//       });
//     }
//   }
  

// Future<bool> loader(String str){
//     return showDialog(context: context,
//         barrierDismissible: false,
//         builder: (context)=> AlertDialog(
//           title: ScalingText(str),
//         ));
//   }

      

// Future<bool> dialog(str){
//   return showDialog(context: context,
//       barrierDismissible: false,
//       builder: (context)=> AlertDialog(
//         title:Text('Message') ,
//         content:Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text(str, style: TextStyle(
//           fontSize: 14,
//           color: Colors.blue.shade900

//         ),),
//         SizedBox(height: 10.0,),
//         Container(
//                     height: 40.0,
//                     child: Material(
//                         borderRadius: BorderRadius.circular(20.0),
//                         shadowColor: Colors.blue.shade900,
//                         color: Colors.blue.shade900,
//                         elevation: 7.0,
//                         child: GestureDetector(
//                           onTap: (){
//                              Navigator.pop(context);
//                              Navigator.pop(context);
                             
//                           },
//                           child: Center(
//                             child: Text(
//                               'Back to List',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'MontSerrat'
//                               ),
//                             ),
//                           ),
//                         )
//                     ),

//                   ),
//         ],) 
        
//       ));
//     }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//                resizeToAvoidBottomPadding: false,
//         appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.blue.shade900),
//         elevation: 15.0,

//         title:Column(children:<Widget>[
//              Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Column(
//                           children: <Widget>[

//                             Row(
                              
//                               children: <Widget>[
//                                 Padding(padding: EdgeInsets.only(left:30)),
//                                 Image(image: AssetImage("assets/domcitylogo2.jpg"), width: 50,height: 50),
                               
//                               ],
//                             ),
//                           ],
//                         ),
//                         Column(
                         
//                           children: <Widget>[
                            
//                             Row(
                              
//                               children: <Widget>[
                               
//                                 Container(
//                                   padding: EdgeInsets.only(top:80),
                                  
                                  
//                                   child: new Text('Dominion City',style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.indigo),),
//                                 ),
//                               ],
//                             ),
//                              Row(
                              
//                               children: <Widget>[
//                                 Container(
//                                   height: 100.0,
//                                   child: new Text('...raising leaders that transforms society',style:TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.indigo),),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//         ]
//         ),
//         backgroundColor: Colors.white,
// ),
// body: Column(
// children: <Widget>[

// Padding(
//   padding: const EdgeInsets.only(top:50.0, left: 20, right: 20),
//   child:  Container(
//   margin: EdgeInsets.all(8.0),
//   // hack textfield height
//   padding: EdgeInsets.only(bottom: 40.0),
//   child: Column(
//     children: <Widget>[
//       TextField(
//                               controller: _meetingTitleController,
//                               decoration: InputDecoration(
//                                   labelText: 'Meeting Title',
//                                   labelStyle: TextStyle(
//                                       fontFamily: 'MontSerrat',
//                                       fontWeight: FontWeight.bold)),
                                      
                              
//                             ),
//                                        SizedBox(height:20),
                              
//        TextField(
//                               controller: _meetingIDeController,
                              
//                               decoration: InputDecoration(
//                                   labelText: 'Meeting ID',
//                                   labelStyle: TextStyle(
//                                       fontFamily: 'MontSerrat',
//                                       fontWeight: FontWeight.bold)),
                              
//                             ),
                            
//       SizedBox(height:20),
          
//          TextField(
//                               controller: _meetingPasswordController,
//                               decoration: InputDecoration(
//                                   labelText: 'Password',
//                                   labelStyle: TextStyle(
//                                       fontFamily: 'MontSerrat',
//                                       fontWeight: FontWeight.bold)),
                              
//                             ),
//       SizedBox(height:20),




//        DropdownButton(
//                             hint: Text(
//                                 'User Category'), // Not necessary for Option 1
//                             value: _selectedCategories,

//                             onChanged: (newValue) {
//                               setState(() {
//                                 _selectedCategories = newValue;
//                               });
//                             },
//                             items: categories.map((marital) {
//                               return DropdownMenuItem(
//                                 child: new Text(marital),
//                                 value: marital,
//                               );
//                             }).toList(),
//                             isExpanded: true,
//                             style: TextStyle(
//                                 fontFamily: 'Monserrati',
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black54),
//                           ),
//                           SizedBox(height:20),

//          Container(
//                         child: TextFormField(
//                           controller: _meetingDateeController,
//                           decoration: InputDecoration(
//                               labelText: 'Meeting Date',
//                               labelStyle: TextStyle(
//                                   fontFamily: 'MontSerrat',
//                                   fontWeight: FontWeight.bold)),
//                           onTap: () {
//                             _selectMeetingDate(context);
//                           },
//                         ),
//                       ),
//                       SizedBox(height:20),

//         TextField(
//                               controller: _meetingTimeController,
//                               decoration: InputDecoration(
//                                   labelText: 'Meeting Time',
//                                   labelStyle: TextStyle(
//                                       fontFamily: 'MontSerrat',
//                                       fontWeight: FontWeight.bold)),
//                               onTap: () {
//                                 _meetingTime(context);
//                               },
//                             ),

//       SizedBox(height:20),
//        Padding(
//          padding: const EdgeInsets.only(left:250.0),
//          child: new RaisedButton(
//                  color: Colors.blue.shade900,
//                 child: new Text("Save", style: TextStyle(color: Colors.white),),
               
//                 onPressed: () {
//                    new Future.delayed(Duration.zero, () {
//                                     loader('Creating Meeting...');
//                    MeetingService.postMeeting(_meetingTitleController.text, "description", _meetingIDeController.text, _meetingDateeController.text, _selectedCategories, _meetingTimeController.text,"Active",_meetingPasswordController.text)
//                    .then((responsefromserver){

//                               setState(() {
                                
//                                  serverresponse = responsefromserver;
//                                         if (serverresponse != null) {
//                                           MeetingService.getAllmeetings()
//                                               .then((meetingFromServer) {
//                                             setState(() {
//                                               _meetings = meetingFromServer.meetings;
//                                               _meetings.removeWhere((item) =>
//                                                   item.meetingdate == null);
//                                               _meetings.removeWhere(
//                                                   (item) => item.meetingTitle == null);
//                                               _meetings.removeWhere(
//                                                   (item) => item.meetingtime == null);

//                                               filteredMeeting = _meetings;
//                                             });
//                                             Navigator.pop(context);
                                           
//                                           });
//                                         }

//                               });
//                    });




//                      dialog('Meeting Saved');
//                    });
//                 },
                 
//                 ),
//        ),
       
//     ],
//   ),
// ),
                  
// ),

// ],







  
// ),




      
//     );
//   }
// }