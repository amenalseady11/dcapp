import 'package:cached_network_image/cached_network_image.dart';
import 'package:dcapp/classes/ProfileClass.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/screens/MemberDepartment.dart';
import 'package:dcapp/screens/MemberTraining.dart';
import 'package:dcapp/screens/Overview.dart';
import 'package:dcapp/screens/MemberTraining.dart';
import 'package:flutter/material.dart';




class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ProfileClass pr = ProfileClass();
    
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
     pr =global.profile;
     global.deptTable = pr.deptTable;
     global.trainTable = pr.trainingTables;
     
     
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.blue.shade900,
      body: ListView(
        
        children: <Widget>[
          Container(
             decoration: BoxDecoration(
             
              color: Colors.blue.shade900,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade800,Colors.blue.shade900, Colors.blue.shade800],),
              
           ),
            child: Stack(
              
              children: <Widget>[
                
                Container(

                  height: 250.0,
                  width: double.infinity,
                  // decoration: BoxDecoration(boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.black.withOpacity(0.2),
                  //       spreadRadius: 3.0,
                  //       blurRadius: 2.0),
                  // ], color: Colors.white),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  
                  top: 50.0,
                  left: 10.0,
                  child: Row(
                    
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                           pr.member.firstName.toUpperCase() + pr.member.surName.toUpperCase(),
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_on, color: Colors.white),
                              Container(
                                width: MediaQuery.of(context).size.width ,
                                child: Text(
                                  
                                  pr.member.state  + ","+ " " + pr.member.country,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height:7.5),
                        
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:200.0),
                  child: TabBar(
                    controller: tabController,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 4.0,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      ),
                      Tab(
                      child: Text(
                        'Department',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Trainings',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height ,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                new PersonalDetails(),
                new DeptDirect(),
                new MembTrain()
              ],
            ),
          )
        ],
      ),
    );
  }
}