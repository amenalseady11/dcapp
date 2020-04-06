
import 'package:dcapp/classes/ProfileClass.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;


class DeptDirectorys extends StatefulWidget {
  @override
  _DeptDirectorysState createState() => _DeptDirectorysState();
}

class _DeptDirectorysState extends State<DeptDirectorys> {
List<DeptDirectory> dept = List();
 
var filteredDeptDirectory = List();
//bool isChecked =false;
//List<AttendanceClass> attendance = new List<AttendanceClass>();
//List<DeptDirectory> dept = List();
 
 
  @override
  void initState() {
    super.initState();
    setState(() {
   

    dept = global.profile.deptDirectory.toList();
    filteredDeptDirectory = dept;
    
   });
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
                              fontSize: 10,
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

                      Text(filteredDeptDirectory.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    filteredDeptDirectory = dept.where((u)=>
                    (u.department.toLowerCase().contains(string.toLowerCase())||
                
                    (u.name.toLowerCase().contains(string.toLowerCase())

                    ||
                
                    (u.email.toLowerCase().contains(string.toLowerCase())
                
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
                  itemCount: filteredDeptDirectory.length,
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
                                               Text(filteredDeptDirectory[index].name, 
                                               style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   fontFamily: 'Monseratti'

                                               ),),
                                             ],
                                           ),
                                          
                                          
                                         ],
                                         
                                       ),
                                        SizedBox(height: 5),
                                     ],
                                   ),
                                   Row(
                                     children:<Widget>[
                                      Text(filteredDeptDirectory[index].department  ),
                                          
                                           Spacer(),
                                          
                                           ]
                                   ),
                                   SizedBox(height: 5),
                                    Row(
                                     children:<Widget>[
                                      Text(filteredDeptDirectory[index].phone +"," +" " +  filteredDeptDirectory[index].email ),
                                          
                                           Spacer(),
                                         
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