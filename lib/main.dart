import 'package:dcapp/classes/ProfileClass.dart';
import 'package:dcapp/screens/Appointment.dart';
import 'package:dcapp/screens/AudioMessage.dart';
import 'package:dcapp/screens/Books.dart';
import 'package:dcapp/screens/DC%20Airforce%20TV.dart';
import 'package:dcapp/screens/DepartmentDirectory.dart';
import 'package:dcapp/screens/Devotionals.dart';
import 'package:dcapp/screens/Donations.dart';
import 'package:dcapp/screens/Events.dart';
import 'package:dcapp/screens/Home.dart';
import 'package:dcapp/screens/LiveStream.dart';
import 'package:dcapp/screens/Login.dart';
import 'package:dcapp/screens/ManageDevotionals.dart';
import 'package:dcapp/screens/ManageEvents.dart';
import 'package:dcapp/screens/ManageNews.dart';
import 'package:dcapp/screens/ManagePrayerRequest.dart';
import 'package:dcapp/screens/MembersMeeting.dart';
import 'package:dcapp/screens/Members.dart';
import 'package:dcapp/screens/Music.dart';
import 'package:dcapp/screens/MusicStore.dart';
import 'package:dcapp/screens/News.dart';
import 'package:dcapp/screens/PrayerRequest.dart';
import 'package:dcapp/screens/Register.dart';
import 'package:dcapp/screens/Testimony.dart';
import 'package:dcapp/screens/Tithe&Offering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(new MyApp(
    
  )
  
  
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dominion City",
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: Login(),
      routes: <String, WidgetBuilder>{
        'Appointment': (BuildContext context)=> new Appointment(),
         'News': (BuildContext context)=> new NewsPage(),
          'Events': (BuildContext context)=> new EventPage(),
           'LiveStream': (BuildContext context)=> new LiveStream(),
            'PrayerRequest': (BuildContext context)=> new PrayerRequestPage(),
             'Testimony': (BuildContext context)=> new Testimony(),
              'Devotionals': (BuildContext context)=> new DevotionalsPage(),
               'Music': (BuildContext context)=> new MusicPage(),
                'Books': (BuildContext context)=> new BookPage(),
                 'Tithe': (BuildContext context)=> new TitheOffering(),
                  'MembersMeeting': (BuildContext context)=> new Meeting(),
                   'Registrations': (BuildContext context)=> new Register(),
                    'AudioMessages': (BuildContext context)=> new AudioMessagePage(),
                     'DCAirforceTv': (BuildContext context)=> new DCAirforce(),
                      'DepartmentDirectory': (BuildContext context)=> new DeptDirectorys(),
      }
    );
  }
}