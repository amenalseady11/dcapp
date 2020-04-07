import 'package:dcapp/screens/CreateDevotionalPage.dart';
import 'package:dcapp/screens/NewsCreatingPage.dart';
import 'package:dcapp/screens/NewsViewPage.dart';
import 'package:dcapp/screens/ReadDevotionalPage.dart';
import 'package:dcapp/services/DevotionalServe.dart';
import 'package:dcapp/services/NewsServe.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/classes/DevotionalsClass.dart' as newDev;
import 'package:dcapp/globals.dart' as global;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';





class ManageDevotionals extends StatefulWidget{
  @override
  _ManageDevotionals createState() => _ManageDevotionals();

}


class _ManageDevotionals extends State<ManageDevotionals>{

  List<newDev.Devotional> _devotionals = List<newDev.Devotional>();
  List<newDev.Devotional> filteredDevotionals = List<newDev.Devotional>();
  




TextEditingController _eventsDateController = new TextEditingController();
TextEditingController _titleController = new TextEditingController();
TextEditingController _descriptionController = new TextEditingController();
TextEditingController _venueController = new TextEditingController();
TextEditingController _timeController = new TextEditingController();
  


  
  
  String title;
  DateTime eventDate;
  DateTime eventTime;
  String venue;
  String description;

  int serverResponse;


  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MMM-dd');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
  }


String getEventsDate(DateTime event){
 
 var date2 = DateTime.now();
 final difference = event.difference(date2).inDays;
 return difference.toString();
}




DateTime _eventsdate = new DateTime(2020);
Future<DateTime> _selectEventDate(BuildContext context) async{
  final DateTime picked = await showDatePicker(
    context: context, 
    initialDate: _eventsdate, 
    firstDate: new DateTime(1900), 
    lastDate: new DateTime.now()
    );
    if(picked !=null && picked != _eventsdate){
      print('Date Selected: ${_eventsdate.toString()}');
      setState(() {
        _eventsdate = picked;

        var formatter = new DateFormat('yyyyy-MM-dd');
        String formatted = formatter.format(_eventsdate);
        
        _eventsDateController.text = formatted.toString();
        
      });
    }
}
TimeOfDay _time = new TimeOfDay.now();

 Future<Null> _eventTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if(picked != null && picked != _time) {
      print('Time selected: ${_time.toString()}');
      setState((){
        _time = picked;
        _timeController.text = _time.format(context);
      });
    }
  }




  @override
  void initState() {
    super.initState();
    setState(() {
      new Future.delayed(Duration.zero, () {
                  loader(' Loading Devotional...');

      DevotionalService.getDevotional()
            .then((devotionalsFromServer) {
          setState(() {
            _devotionals = devotionalsFromServer.devotionals;
            _devotionals.removeWhere((item) => item.title == null);
            _devotionals.removeWhere((item) => item.devotionaltext == null);
            _devotionals.removeWhere((item) => item.datePublished == null);
            filteredDevotionals = _devotionals;
            filteredDevotionals.sort((b, a) => a.datePublished.compareTo(b.datePublished));

            Navigator.pop(context);
          });
        });
      });

   });
  }
    
   
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
          title: Text('Manage  Devotionals', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),
          actions: <Widget>[

            new IconButton(icon: new Icon(Icons.add,color: Colors.white,),onPressed: (){ 
               Navigator.push(context, MaterialPageRoute(builder: (context){
                                return CreateDevotionalPage();
                            }));},),

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

                      Text('Number of Devotionals', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredDevotionals.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Devotionals...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredDevotionals = _devotionals.where((u)=>
                    (u.datePublished.toString().toLowerCase().contains(string.toLowerCase()))||
                    (u.title.toString().toLowerCase().contains(string.toLowerCase()))
                    ).toList();
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
                padding: EdgeInsets.all(0.0),
                itemCount: filteredDevotionals.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {});
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: 
                          
                          Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.only(left:18.0),
                                   child: 
                                   Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       
                                       Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                         children: <Widget>[
                                           Row(
                                             children: <Widget>[
                                               Container(
                                                 width: MediaQuery.of(context).size.width/1.5,
                                                 child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: <Widget>[
                                                     Text(filteredDevotionals[index].title , 
                                                     style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.bold,
                                                         fontFamily: 'Monseratti'

                                                     ),),
                                                   ],
                                                 ),
                                               ),
                                               SizedBox(width: 20),

                                             ],
                                             
                                           ),
                                           SizedBox(height:10),
                                          
                                         ],
                                       ),
                                      
                                     
                                     ],
                                   ),
                                  
                                 ),
                                 
                                 SizedBox(height:2),
                                   Padding(
                                     padding: const EdgeInsets.only(top:1, left:18),
                                     child: Row(
                                       children: <Widget>[
                                         Icon(Icons.timer,size: 15, color:Colors.grey),
                                         Text(getDate(
                                                    filteredDevotionals[index].datePublished)),
                                         
                                         SizedBox(width:3),
                                         
                                         SizedBox(width: 20),
                                          Icon(Icons.thumb_up, color:Colors.grey , size: 15,),
                                         Text(filteredDevotionals[index].likeCount.toString()),
                                         
                                         
                                         
                                       ],
                                     ),

                                     
                                   ),
                                  
                                 

                                ],
                              ),
                              Spacer(),
                             Column(
                               children:<Widget>[
                                   new IconButton
                              (
                                padding: EdgeInsets.only(left:0),
                                icon: Icon(Icons.arrow_right, size: 50,),
                               onPressed: () {
                                 
                                   Navigator.push(context, MaterialPageRoute(builder: (context){
                                    global.rawText = filteredDevotionals[index].rawtext;
                                    global.devotionalTitle = filteredDevotionals[index].title;
                                    global.devotionaId = filteredDevotionals[index].id;
                                return CreateDevotionalPage();
                                     }));
              },
                              ),
                              Row(
                               children: <Widget>[
                                // Text( filteredDisciple[index])
                               ],
                              ),
                                  ])
                            ],
                          ),
                          
                        ),
                      ));
                }),
          )
                          
          ]),
                      );
               
  }


}




