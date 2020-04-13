
                         
                         
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/screens/DepartmentsMessage.dart';
import 'package:dcapp/screens/MVPMessage.dart';
import 'package:dcapp/screens/SimpleMessage.dart';
import 'package:dcapp/screens/DepartmentHead.dart';
import 'package:dcapp/screens/Trainings.dart';
import 'package:dcapp/screens/ZoneHead.dart';
import 'package:flutter/material.dart';


class SendSMS extends StatefulWidget{
  @override
  _SendSMS createState()=> _SendSMS();

}

class _SendSMS extends State<SendSMS>{

TextEditingController smsController = new TextEditingController();
String message;
 final List<String> categories = [
   "All Members", 
 "All Males", 
  "All Females", 
  "All Zonal Leaders",
 "All Workers", 
 "Select Department",
    "MVP",
   
   ];
  List<String> filteredsms = List();



  @override
  void initState() {
    super.initState();
    setState(() {

      filteredsms = categories;
      
     
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
              
            Text(' Categories', style: TextStyle(
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
                filteredsms = categories.where((u)=>
                (u.toLowerCase().contains(string.toLowerCase()))).toList();
              });


            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount:  categories.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    splashColor: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: (){
                      setState(() {
                        
                        Navigator.push(context, MaterialPageRoute(builder: (context){ 
                          if(index == 0){
                            global.selectedCategory = categories[index];
                            return MembersMessage(); 
                            
                            }
                          
                          else if(index == 1){
                             global.selectedCategory = categories[index];
                            return MembersMessage();}
                         else if(index == 2){
                            global.selectedCategory = categories[index];
                           return MembersMessage();}
                         else if(index == 3){
                             global.selectedCategory = categories[index];
                           return MembersMessage();}
                         else if(index == 4){
                            global.selectedCategory = categories[index];
                           return MembersMessage();}
                         else if(index == 5){
                              global.selectedCategory = categories[index];
                           return DeptMessage();}
                         else if(index == 6){
                              global.selectedCategory = categories[index];
                           return MVPMessage();}
                        
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
                            Text(filteredsms[index].toString(), style: TextStyle(
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




