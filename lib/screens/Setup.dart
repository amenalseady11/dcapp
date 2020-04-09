import 'dart:developer';

import 'package:dcapp/screens/AccessDenied.dart';
import 'package:dcapp/screens/Branch.dart';
import 'package:dcapp/screens/BranchHead.dart';
import 'package:dcapp/screens/DepartmentHead.dart';
import 'package:dcapp/screens/Departments.dart';
import 'package:dcapp/screens/DonationType.dart';
import 'package:dcapp/screens/EmailTemplate.dart';
import 'package:dcapp/screens/ExpenditureType.dart';
import 'package:dcapp/screens/IncomeType.dart';
import 'package:dcapp/screens/SMSTemplate.dart';
import 'package:dcapp/screens/Trainings.dart';
import 'package:dcapp/screens/Zone.dart';
import 'package:dcapp/screens/ZoneHead.dart';
import 'package:dcapp/screens/ServiceType.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;


class Setup extends StatefulWidget{
  @override
  _Setup createState()=> _Setup();

}

class _Setup extends State<Setup>{


 final List<SetupItems> setup = new List<SetupItems>();
 
 
  List<SetupItems> filteredsetup = new List<SetupItems>();

 getAction(
     
      String title,
    
      String checkifBH,
      String checkifZN,
      String checkifDH,
      int index,
      String priviledge) {
//Checkif......Should Y or N
    if (checkifBH == "Y" ) {
      if (global.checkifbranchhead == "Yes") {
        //Grant Right because He/She is a branchhead
        //setState(() {
           filteredsetup[index].grant='Granted';
       // });
       
        return  Text(filteredsetup[index].title.toString(), style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti'

                            ));
     
      }
    } 
    
    if (checkifDH == "Y") {
      if (global.checkifdepthhead == "Yes") {
      // setState(() {
           filteredsetup[index].grant='Granted';
      //  });
        //Grant Right because He/She is a branchhead
        return Text(filteredsetup[index].title.toString(), style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti'

                            ));
     
      }
    } 
    
    if (checkifZN == "Y") {
      if (global.checkifzonehead == "Yes") {
        //setState(() {
           filteredsetup[index].grant='Granted';
      //  });
        //Grant Right because He/She is a branchhead
        return Text(filteredsetup[index].title.toString(), style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti'

                            ));
     
      }
    } 
     
     
      //Check if he was given the priviledge
      if (global.roles.where((c) => c.action == priviledge).length > 0) {
       // setState(() {
           filteredsetup[index].grant='Granted';
       // });
        return Text(filteredsetup[index].title.toString(), style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti'

                            ));
      } else {
        // setState(() {
           filteredsetup[index].grant='Denied';
       // });
          return Text(filteredsetup[index].title.toString(), style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti'

                            ));
      }
    
    
  }

Future<bool> dialog(str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  str,
                  style: TextStyle(fontSize: 14, color: Colors.blue.shade900),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 40.0,
                  child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.blue.shade900,
                      color: Colors.blue.shade900,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            'Back to List',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontSerrat'),
                          ),
                        ),
                      )),
                ),
              ],
            )));
  }

  @override
  void initState() {
    super.initState();
   
   setup.add(new SetupItems('Branch','Can Setup Branch', 'N', 'Denied'));
   setup.add(new SetupItems('Branch Head','Can Setup Branch Head', 'N', 'Denied'));
   setup.add(new SetupItems('Zone','Can Setup Zone', 'Y', 'Denied'));
   setup.add(new SetupItems('Zone Head','Can Setup Zone Head', 'Y', 'Denied'));
   setup.add(new SetupItems('Departments','Can Setup Department', 'Y', 'Denied'));
   setup.add(new SetupItems('Department Head','Can Setup Department Head', 'Y', 'Denied'));
   setup.add(new SetupItems('Trainings','Can Setup Trainings', 'N', 'Denied'));
   setup.add(new SetupItems('Donation Type','Can Setup Donation Types', 'N', 'Denied'));
   setup.add(new SetupItems('Expenditure Type','Can Setup Expenditure Types', 'N', 'Denied'));
   setup.add(new SetupItems('Income Type','Can Setup Income Types', 'N', 'Denied'));
   setup.add(new SetupItems('Email Templates','Can Setup Email Templates', 'Y', 'Denied'));
   setup.add(new SetupItems('SMS Templates','Can Setup SMS Templates','Y', 'Denied'));

    setState(() {
      filteredsetup = setup;
     
    });

  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
        elevation: 7.0,
        actionsIconTheme: new IconThemeData(color:  Colors.white),

        title: Row(
          children: <Widget>[
              new Icon(Icons.settings),
            Text(' Setup', style: TextStyle(
                fontWeight:  FontWeight.bold,
                fontSize: 16.0,
                fontFamily: 'Monseratti',
                color: Colors.white

            ),),
          ],
        ),
        actions: <Widget>[

         

        ],
        backgroundColor: Colors.blue.shade900,

      ),
      body:
      Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Search List...'
            ),
            onChanged: (string){

              setState(() {
                filteredsetup = setup.where((u)=>
                (u.title.toLowerCase().contains(string.toLowerCase()))).toList();
              });


            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount:  setup.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    splashColor: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: (){
                      
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          if(index == 0){
                              if(filteredsetup[index].grant=='Granted'){
                               return Branch();
                            }else{
                            //  dialog('Access Denied');
                            return Branch();
                            }
                          }
                          else if(index == 1){
                            if(filteredsetup[index].grant=='Granted'){
                               return BranchHead();
                            }else{
                              //  dialog('Access Denied');
                            return BranchHead();
                            }

                           
                            }
                         else if(index == 2){
                            if(filteredsetup[index].grant=='Granted'){
                               return ZoneScreen();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }

                           
                           }
                         else if(index == 3){
                           if(filteredsetup[index].grant=='Granted'){
                               return ZoneHead();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }
                           
                           
                           }
                         else if(index == 4){
                           if(filteredsetup[index].grant=='Granted'){
                               return Departments();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }
                           
                           
                           }
                         else if(index == 5){
                           if(filteredsetup[index].grant=='Granted'){
                               return DepartmentHead();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }
                           
                           }
                         else if(index == 6){
                            if(filteredsetup[index].grant=='Granted'){
                               return Trainings();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }
                            
                            }
                        // else if(index == 7){return Service();}

                         else if(index == 7){
                            if(filteredsetup[index].grant=='Granted'){
                               return Donation();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }
                           
                           }
                         else if(index == 8){
                           if(filteredsetup[index].grant=='Granted'){
                               return Expenditure();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }
                           
                           }
                         else if(index == 9){

                           if(filteredsetup[index].grant=='Granted'){
                               return Income();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }

                           }
                         else if(index == 10){
                           
                          if(filteredsetup[index].grant=='Granted'){
                               return Email();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }
                           
                           }
                         else if(index == 11){
                           if(filteredsetup[index].grant=='Granted'){
                               return SMS();
                            }else{
                              //  dialog('Access Denied');
                            return AccessDenied();
                            }
                           
                           }
                          
                         // return  Sections('States', filteredstates[index].toString());
                        }));

                      
                    },

                    child:  Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            getAction(filteredsetup[index].title, filteredsetup[index].check, "N", "N", index, filteredsetup[index].priviledge)
                           

                          ],
                        ),
                      ),
                    )
                    ,
                  );

                }),
          )
        ],
      ),
    );
  }


}

class SetupItems{
String title;
String priviledge;
String check;
String grant;
SetupItems(this.title,this.priviledge, this.check, this.grant);
}
