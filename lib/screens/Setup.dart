import 'dart:developer';

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


class Setup extends StatefulWidget{
  @override
  _Setup createState()=> _Setup();

}

class _Setup extends State<Setup>{


 final List<String> setup = ["Branch", "Branch Head",  "Zone", "Zone Head",
 "Departments", 
 "Department Head",
    "Trainings",
    "Service Type",
    "Donation Type",
     "Expenditure Type",
    "Income Type" ,
    'Email Templates',
    'SMS Templates',
   ];
  List<String> filteredsetup = List();



  @override
  void initState() {
    super.initState();
    setState(() {

      filteredsetup = setup;
      print(filteredsetup.length);
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
                (u.toLowerCase().contains(string.toLowerCase()))).toList();
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
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          if(index == 0){return Branch();}
                          else if(index == 1){return BranchHead();}
                         else if(index == 2){return ZoneScreen();}
                         else if(index == 3){return ZoneHead();}
                         else if(index == 4){return Departments();}
                         else if(index == 5){return DepartmentHead();}
                         else if(index == 6){
                           new Future.delayed(Duration.zero, (){
                             
                           });
                           
                           return Trainings();}
                         else if(index == 7){return Service();}
                         else if(index == 8){return Donation();}
                         else if(index == 9){return Expenditure();}
                         else if(index == 10){return Income();}
                         else if(index == 11){return Email();}
                         else if(index == 12){return SMS();}
                          
                         // return  Sections('States', filteredstates[index].toString());
                        }));

                      });
                    },

                    child:  Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(filteredsetup[index].toString(), style: TextStyle(
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
      ),
    );
  }


}


