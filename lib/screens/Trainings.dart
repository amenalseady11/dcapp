import 'dart:core';


import 'package:dcapp/classes/BranchClass.dart';
import 'package:dcapp/classes/DiscipleshipClass.dart' as discipleshipClass;

import 'package:dcapp/classes/memberClass.dart' as MemClass;
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/classes/zoneClass.dart';
import 'package:dcapp/services/DiscipleshipServe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';


//import 'package:progress_indicators/progress_indicators.dart';


class Trainings extends StatefulWidget{
 // final int subId;
 
  @override
  _Trainings createState() => _Trainings();

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
class _Trainings extends State<Trainings>{

  
 TextEditingController _trainNametextFieldController = TextEditingController();
    
     String trainName;


//   List<BranchClass> filteredBranches = List();
//  var filteredMembers = List();
//   MemClass.MemberClass _memberClass = new MemClass.MemberClass();

  //List<ZoneClass> zn = List<ZoneClass>();
   List<discipleshipClass.Discipleship> disc =  List<discipleshipClass.Discipleship>();

    var filteredDiscipleship = List();

  @override
  void initState() {
    super.initState();
    setState(() {
  new Future.delayed(Duration.zero, () {
                  loader('Loading Training...');
     

     DiscipleshipService.getDiscipleship().then((deptFromServer) {
        setState(() {
          global.discipleship = deptFromServer;
          global.discipleship.discipleships.removeWhere((item) => item.trainingName == null);
          disc = global.discipleship.discipleships;
          filteredDiscipleship = disc;
         Navigator.pop(context);
        });
      });

  });
   });
  }
    
    String departmentName;
    int serverResponse;

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
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Manage  Trainings', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),
          actions: <Widget>[

            new IconButton(icon: new Icon(Icons.add,color: Colors.white,),onPressed: (){_displayDialog(context);},),

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

                      Text('Number of Trainings', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredDiscipleship.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Training...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredDiscipleship = disc.where((u)=>
                    (u.trainingName.toLowerCase().contains(string.toLowerCase()))).toList();
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
                  itemCount: filteredDiscipleship.length,
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
                                               Text(filteredDiscipleship[index].trainingName , 
                                               style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                   fontFamily: 'Monseratti'

                                               ),),
                                             ],
                                           ),
                                           SizedBox(width: 20),
                                          
                                         ],
                                         
                                       ),
                                     ],
                                   ),
                                   Column(children:<Widget>[
                                     
                                   ])
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



 _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(' Add/Update Training'),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _trainNametextFieldController,
                  decoration: InputDecoration(hintText: "Enter Training"),
                  onChanged: (String value) {
                        trainName = value;
                  },
                ),
                
              ],
            ),
            
            actions: <Widget>[
              new RaisedButton(
                color: Colors.blue.shade900,
                child: new Text('Save'),
                onPressed: () {
                  //save to server
                 new Future.delayed(Duration.zero, () {
                  loader('Saving Training...');

                 

                    DiscipleshipService.saveDiscipleship(_trainNametextFieldController.text).then((responseFromServer) {
                    setState(() {
                    serverResponse = responseFromServer;
                   if(serverResponse !=null){
                        discipleshipClass.Discipleship de = new discipleshipClass.Discipleship();

                    int id = serverResponse;
                    de.trainingId = id;
                    
                    de.trainingName = _trainNametextFieldController.text;
                   
                    global.discipleship.discipleships.add(de);
                    filteredDiscipleship= global.discipleship.discipleships;
                   }
                    Navigator.pop(context);
                    dialog('Training Saved');
                    });
                   });
                 });
                }),

                new RaisedButton(
                color: Colors.red,
                child: new Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              new RaisedButton(
                color: Colors.grey,
                child: new Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
                
                
                
                
                
                
                
                
                
                
                
                
                ]
          );},
          );
        }
  }




