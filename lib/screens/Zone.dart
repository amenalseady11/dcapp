import 'package:dcapp/classes/BranchClass.dart';
import 'package:dcapp/services/zoneServ.dart';
import 'package:flutter/cupertino.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/classes/zoneClass.dart';
import 'package:dcapp/globals.dart' as global;
//import 'package:progress_indicators/progress_indicators.dart';


class ZoneScreen extends StatefulWidget{
 // final int subId;
 
  @override
  _ZoneScreen createState() => _ZoneScreen();

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
class _ZoneScreen extends State<ZoneScreen>{
 

  final _debouncer = Debouncer(milliseconds: 500);
   TextEditingController _zonetextFieldController = TextEditingController();
    TextEditingController _addresstextFieldController = TextEditingController();
    
     String zone;
   String address;
   int branchId;
  int serverResponse;
  List<ZoneClass> zones = List();
  var filteredZones = List();
  List<BranchClass> filteredBranches = List();

  List<ZoneClass> zn = List<ZoneClass>();

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
  void initState() {
    super.initState();
    setState(() {
   

    new Future.delayed(Duration.zero, () {
                  loader('Loading Zones...');
      ZoneService.getZones().then((zonesFromServer) {
        setState(() {
            zn =global.zones;
          filteredBranches=global.branches;
          global.zones = zonesFromServer;
        global.zones.removeWhere((item) => item.zoneName == null);
        filteredZones = global.zones.where((c)=>c.branch.branchId==global.profile.member.branch.branchId).toList();
           Navigator.pop(context);
        });
         });
      });
   
   });
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Manage  Zone', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),
          actions: <Widget>[

            new IconButton(icon: new Icon(Icons.add,color: Colors.white,),onPressed: (){_showDialog();},),

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

                      Text('Number of Zones', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredZones.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Zones...'
                    ),
                    onChanged: (string){

                   setState(() {
                    filteredZones = zn.where((u)=>
                    (u.zoneName.toLowerCase().contains(string.toLowerCase()))).toList();
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
                  itemCount: filteredZones.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: (){
                        setState(() {
                          _zonetextFieldController.text= filteredZones[index].zoneName;
                            _addresstextFieldController.text =filteredZones[index].adress;
                            branchId = filteredZones[index].branch[index].branchID;
                           _showDialog();
                       });
                      },

                      child:  Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             Text(filteredZones[index].zoneName, style: TextStyle(
                                  fontSize: 15.0,
                                 fontFamily: 'Monseratti'

                             ),),

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



 void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Add/Update Zone"),
         content: Column(
           mainAxisSize: MainAxisSize.min,
           
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
             TextField(
                  controller: _zonetextFieldController,
                  decoration: InputDecoration(hintText: "Enter Zone Name"),
                  onChanged: (String value) {
                        zone = value;
                  },
                ),
                 TextField(
                  controller: _addresstextFieldController,
                  decoration: InputDecoration(hintText: "Address"),
                  onChanged: (String value) {
                        address = value;
                  },
                  
                ),
                
                SearchableDropdown.single(
                  
                  items: filteredBranches
                      .map((value) => DropdownMenuItem(
                            child: Text(value.branchName),
                            value: value.branchID,
                          ))
                      .toList(),
                      
                  onChanged: (int value) {
                        branchId = value;
                  },
                  isExpanded: false,
                  hint: Text('Select  Branch'),
                  
                ),
           ],
         ),
            
          actions: <Widget>[

            // usually buttons at the bottom of the dialog
            
                   
                    
            new RaisedButton(
              color: Colors.blue.shade900,
              child: new Text("Save"),
              onPressed: () {

                //save to server
                 new Future.delayed(Duration.zero, () {
                  loader('Saving Zone...');

                    ZoneService.saveZones(zone, address, branchId).then((responseFromServer) {
                    setState(() {
                    serverResponse = responseFromServer;
                   if(serverResponse !=null){
                      ZoneService.getZones().then((zonesFromServer) {
        setState(() {
          filteredBranches=global.branches;
          global.zones = zonesFromServer;
        global.zones.removeWhere((item) => item.zoneName == null);
        filteredZones = global.zones.where((c)=>c.branch.branchId==global.profile.member.branch.branchId).toList();
        });
      });
                       Navigator.pop(context);
                    dialog('Zone Saved');
                   }
                  else{
                     Navigator.pop(context);
                    dialog('Error Saving Zone');
                  }
                   

                    });
                    
                   });
                 });
                   
              
              },
              
            ),
             new RaisedButton(
               color: Colors.grey,
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          
        );
      },
    );
  }

}


