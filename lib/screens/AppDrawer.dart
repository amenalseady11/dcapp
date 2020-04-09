import 'package:dcapp/screens/Dashboard.dart';
import 'package:dcapp/screens/ExpenditureType.dart';
import 'package:dcapp/screens/IncomeType.dart';
import 'package:dcapp/screens/ManageExpenditure.dart';
import 'package:dcapp/screens/ManageIncome.dart';
import 'package:dcapp/screens/SplashScreen.dart';

import 'RoleManageMent.dart';
import 'UserManagement.dart';

import 'Attendance.dart';
import 'ManageMeeting.dart';

import 'package:image_picker/image_picker.dart';

import 'DiscipleshipStatus.dart';
import 'ManageTestimonies.dart';
import 'Members.dart';
import 'Profile.dart';
import 'MVP.dart';
import 'ManagePrayerRequest.dart';
import 'ManageEvents.dart';
import 'ManageDevotionals.dart';
import 'ManageNews.dart';
import 'SendSMS.dart';
import 'Setup.dart';
import 'Forms.dart';
import 'BookStore.dart';
import 'ManageAudioMessages.dart';
import 'MusicStore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:cached_network_image/cached_network_image.dart';

class AppDrawer extends StatelessWidget {
  File _image;

  void _uploadFile(filePath) async {
    try {
      var formData = FormData.fromMap({
        "memberId": global.profile.member.memberId,
        "files": MultipartFile.fromFileSync(filePath.path)
      });
      Response response = await Dio().post(
          "http://apekflux-001-site1.btempurl.com/v2/api/members/uploadprofile",
          data: formData);
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  getAction(
      IconData icn,
      String title,
      var screen,
      String checkifBH,
      String checkifZN,
      String checkifDH,
      BuildContext context,
      String priviledge) {
//Checkif......Should Y or N
    if (checkifBH == "Y" ) {
      if (global.checkifbranchhead == "Yes") {
        //Grant Right because He/She is a branchhead
        return CustomListTile(
            icn,
            title,
            () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return screen;
                  }))
                });
     
      }
    } 
    
    if (checkifDH == "Y") {
      if (global.checkifdepthhead == "Yes") {
        //Grant Right because He/She is a branchhead
        return CustomListTile(
            icn,
            title,
            () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return screen;
                  }))
                });
     
      }
    } 
    
    if (checkifZN == "Y") {
      if (global.checkifzonehead == "Yes") {
        //Grant Right because He/She is a branchhead
        return CustomListTile(
            icn,
            title,
            () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return screen;
                  }))
                });
     
      }
    } 
     
     
      //Check if he was given the priviledge
      if (global.roles.where((c) => c.action == priviledge).length > 0) {
        return CustomListTile(
            icn,
            title,
            () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return screen;
                  }))
                });
      } else {
        return SizedBox(height: 0);
      }
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            color: Colors.blue.shade900,
            child: new DrawerHeader(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      _uploadFile(image);

                      _image = image;

                      (context as Element).markNeedsBuild();
                    },
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child: CachedNetworkImage(
                        imageUrl:
                            'http://apekflux-001-site1.btempurl.com/v2/api/members/GetFile?memberId=' +
                                global.profile.member.memberId.toString(),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.blue, BlendMode.dstIn),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20.0, color: Colors.black),
                              ]),
                        ),
                        placeholder: (context, url) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(),
                              height: 50,
                              width: 50,
                            ),
                          ],
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    global.profile.member.firstName +
                        " " +
                        global.profile.member.surName,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    global.profile.position,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          new Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10),
                  child: Material(
                    elevation: 7.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      //  controller: searchController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          //prefixIcon: Icon(Icons.search, color: Colors.red, size: 30.0, ),
                          contentPadding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          hintText: 'Search List...',
                          suffixIcon: InkWell(
                            splashColor: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                //  return SearchResult(filteredRatio,searchController.text, summary);
                              }));
                            },
                            child: Icon(Icons.search),
                          )),
                    ),
                  ),
                ),
                CustomListTile(
                    Icons.account_box,
                    'My Profile',
                    () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Profile();
                          }))
                        }),

                        getAction( Icons.dashboard, 'Dashboard', Dashboard(), 'Y', 'N', 'N', context, 'Can View Dashboard'),
                        getAction( Icons.check_circle, 'Attendance', Attendance(), 'Y', 'Y', 'Y', context, 'Can Manage Attendance'),
                        getAction( Icons.message, 'Send SMS', SendSMS(), 'Y', 'N', 'N', context, 'Can Send SMS'),
                        getAction( Icons.message, 'Send Email', Dashboard(), 'Y', 'N', 'N', context, 'Can Send Email'),
                        getAction( Icons.people, 'Manage Members', MemberScreen(), 'Y', 'Y', 'Y', context, 'Can View Members'),
                        getAction( Icons.group_add, 'Manage MVP', MVP(), 'Y', 'N', 'N', context, 'Can Manage MVP'),
                        getAction( Icons.queue, 'View Prayer Requests', ManagePrayerRequest(), 'Y', 'N', 'N', context, 'Can Manage Prayer Request'),
                        getAction( Icons.devices_other, 'View  Testimonies', ManageTestimony(), 'Y', 'N', 'N', context, 'Can Manage Testimonies'),
                        getAction( Icons.event, 'Manage Events', ManageEvents(), 'N', 'N', 'N', context, 'Can Manage Events and Calendar'),
                        getAction( Icons.web, 'Manage News', ManageNews(), 'N', 'N', 'N', context, 'Can Manage News Feeds'),
                        getAction( Icons.web_asset, 'Manage Devotionals', ManageDevotionals(), 'N', 'N', 'N', context, 'Can Manage Devotionals'),
                        getAction( Icons.folder, 'Form Management', Forms(), 'N', 'N', 'N', context, 'Can Manage Forms'),
                        getAction( Icons.music_note, 'Manage Music Store', Music(), 'N', 'N', 'N', context, 'Can Manage Music Store'),
                        getAction( Icons.book, 'Manage Book Store', BookStore(), 'N', 'N', 'N', context, 'Can Manage Book Store'),
                        getAction( Icons.audiotrack, 'Manage Audio Messages', Audio(), 'N', 'N', 'N', context, 'Can Manage Messages'),
                        getAction( Icons.live_tv, 'DC Airfore TV', null, 'N', 'N', 'N', context, 'Can Manage DC Airforce TV'),
                        getAction( Icons.people_outline, 'View Discipleship Status', DiscipleshipStatus(), 'Y', 'N', 'N', context, 'Can View Discipleship Status'),
                        getAction( Icons.group_work, 'Role Management', RoleManagement(), 'Y', 'N', 'N', context, 'Can Create Roles'),
                        getAction( Icons.attach_money, 'Expenditure', ManageExpenditure(), 'Y', 'N', 'N', context, 'Can Manage Finances'),
                        getAction( Icons.attach_money, 'Income', ManageIncome(), 'Y', 'N', 'N', context, 'Can Manage Finances'),
                        getAction( Icons.person_pin, 'Manage Meeting', ManageMeeting(), 'Y', 'Y', 'Y', context, 'Can Manage Meetings'),
                        getAction( Icons.person, 'User Management', Usermanagement(), 'Y', 'N', 'N', context, 'Can Manage Users'),
                        getAction( Icons.report, 'Reports', null, 'N', 'N', 'N', context, 'Can View Report'),
                        getAction( Icons.settings_applications, 'Setup', Setup(), 'Y', 'N', 'N', context, 'Can Setup'),
                  
               
               
                CustomListTile(
                    Icons.lock,
                    'Exit App',
                    () => exit(0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, bottom: 6),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
        ),
        child: InkWell(
          splashColor: Colors.blueAccent,
          onTap: onTap,
          child: Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon, color: Colors.blue.shade900),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Text(
                        text,
                        style:
                            TextStyle(fontSize: 14.0, fontFamily: 'Monseratti'),
                      ),
                    )
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
