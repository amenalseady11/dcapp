import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:dcapp/services/branchServ.dart';
import 'package:dcapp/classes/BranchClass.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/globals.dart' as global;

//import 'package:progress_indicators/progress_indicators.dart';


class Branch extends StatefulWidget{
 // final int subId;
 
  @override
  _Branch createState() => _Branch();

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
class _Branch extends State<Branch>{
 

  final _debouncer = Debouncer(milliseconds: 500);
    TextEditingController _branchtextFieldController = TextEditingController();
    TextEditingController _statetextFieldController = TextEditingController();
    TextEditingController _citytextFieldController = TextEditingController();
    TextEditingController _countrytextFieldController = TextEditingController();
   int parentID;
   int serverResponse;

   String branch;
   String state;
   String city;
   String country;
  List<BranchClass> branches = List();
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
     branches =global.branches;
     filteredBranches=global.branches;
   });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Manage  Branches', style: TextStyle(
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

                      Text('Number of Branches', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filteredBranches.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Branch...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredBranches = branches.where((u)=>
                    (u.branchName.toLowerCase().contains(string.toLowerCase())||
                
                    (u.city.toLowerCase().contains(string.toLowerCase())||
                
                    (u.country.toLowerCase().contains(string.toLowerCase())||
                    (u.state.toLowerCase().contains(string.toLowerCase())))))).toList();
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
                  itemCount: filteredBranches.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: (){
                        setState(() {
                         _branchtextFieldController.text= filteredBranches[index].branchName;
                            _citytextFieldController.text =filteredBranches[index].city;
                            _countrytextFieldController.text = filteredBranches[index].country;
                            _statetextFieldController.text = filteredBranches[index].state;
                            parentID = filteredBranches[index].parentId;
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
                              Text(filteredBranches[index].branchName, style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  
                                  fontFamily: 'Monseratti'

                             ),),
                              SizedBox(height:10),
                               Text(filteredBranches[index].state +', '+filteredBranches[index].city +', '+ filteredBranches[index].country, style: TextStyle(
                                  fontSize: 10.0,
                                 color: Colors.grey,
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
          title: new Text("Add/Update Branch"),
         content: Column(
           mainAxisSize: MainAxisSize.min,
           
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
             TextField(
                  controller: _branchtextFieldController,
                  decoration: InputDecoration(hintText: "Enter Branch Name"),
                  onChanged: (String value) {
                        branch = value;
                  },
                ),
                 TextField(
                  controller: _statetextFieldController,
                  decoration: InputDecoration(hintText: "State"),
                  onChanged: (String value) {
                        state = value;
                  },
                  
                ),
                 TextField(
                  controller: _citytextFieldController,
                  decoration: InputDecoration(hintText: "City"),
                  onChanged: (String value) {
                        city = value;
                  },
                ),
                 TextField(
                  controller: _countrytextFieldController,
                  decoration: InputDecoration(hintText: "Country"),
                  onChanged: (String value) {
                        country = value;
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
                        parentID = value;
                  },
                  isExpanded: false,
                  hint: Text('Select Parent Branch'),
                  
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
                  loader('Saving Branch...');

                    BranchService.saveBranches(branch, state, city,country, parentID).then((responseFromServer) {
                    setState(() {
                    serverResponse = responseFromServer;
                   if(serverResponse !=null){
                     BranchClass br= new BranchClass();
                     int id = serverResponse;
                     br.branchID =id;
                     br.branchName = branch;
                     br.state =state;
                     br.city =city;
                     br.country =country;
                     br.parentId =parentID;
                    branches.add(br);
                    filteredBranches =branches;
                   }
                  
                    Navigator.pop(context);
                    dialog('Branch Saved');

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


