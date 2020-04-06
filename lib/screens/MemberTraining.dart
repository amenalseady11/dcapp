import 'package:dcapp/classes/ProfileClass.dart';
import 'package:dcapp/services/ProfileServ.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;
class MembTrain extends StatefulWidget {
  @override
  _MembTrainState createState() => _MembTrainState();
}

class _MembTrainState extends State<MembTrain> {
   ProfileClass pr = ProfileClass();
   List<TrainingTable> tr = List();
    
  @override
  void initState() {
    super.initState();
  
     pr =global.profile;
     tr = global.profile.trainingTables.toList();
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      //  decoration: BoxDecoration(
             
      //         color: Colors.blue.shade900,
      //         gradient: LinearGradient(
      //           begin: Alignment.topCenter,
      //           end: Alignment.center,
      //           colors: [Colors.white, Colors.blue.shade800],),
              
      //      ),
      child: SingleChildScrollView(
        
        child: 
         DataTable(
           columnSpacing: 25,
           
           
           columns: <DataColumn>[
             DataColumn(
               label: Text('Training', ),
               numeric: false,
               ),
                DataColumn(
               label: Text('Status'),
               numeric: false,
               ),
               DataColumn(
                 
               label: Text('Date Started'),
               numeric: false,
               ),
                DataColumn(
               label: Text('Date Ended'),
               numeric: false,
               ),
           ], 
           
           rows: global.trainTable.map((train)=>
           DataRow(
             cells: [
               
               DataCell(Text(train.training,style: TextStyle(fontSize:10),)),
                 DataCell(Text(train.status,style: TextStyle(fontSize:10),)),
                   DataCell(Text(train.dateStarted.toString(),style: TextStyle(fontSize:10),)),
                   DataCell(Text(train.dateEnded.toString(),style: TextStyle(fontSize:10),))
             ])
           ).toList()
           
           )

       
      ),
    );
  }

 
}