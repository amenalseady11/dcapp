import 'package:dcapp/screens/DC%20Airforce%20TV.dart';
import 'package:dcapp/screens/DCRadio.dart';
import 'package:dcapp/screens/DepartmentDirectory.dart';
import 'package:dcapp/screens/MembersMeeting.dart';
import 'package:dcapp/services/DiscipleshipStatusServe.dart';
import 'package:dcapp/services/TokenServe.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dcapp/screens/AudioMessage.dart';
import 'package:dcapp/screens/Books.dart';
import 'package:dcapp/screens/Devotionals.dart';
import 'package:dcapp/screens/Events.dart';
import 'package:dcapp/screens/Music.dart';
import 'package:dcapp/screens/News.dart';
import 'package:dcapp/screens/PrayerRequest.dart';
import 'package:dcapp/screens/Testimony.dart';
import 'package:dcapp/services/BranchHeadServ.dart';
import 'package:dcapp/services/deptServ.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/screens/AppDrawer.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:dcapp/services/branchServ.dart';
import 'package:dcapp/services/zoneServ.dart';
import 'package:dcapp/services/memberServ.dart';
import 'package:dcapp/globals.dart' as global;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final FirebaseMessaging _messaging = new FirebaseMessaging();

  TabController tabcontroller;
  initState() {
    super.initState();

    _messaging.getToken().then((token) {
      TokenService.postToken(global.profile.member.memberId, token);
      // print(token);
    });
    BranchService.getBranches().then((branchesFromServer) {
      setState(() {
        global.branches = branchesFromServer;

        global.branches.removeWhere((item) => item.branchName == null);
      });
    });

    ZoneService.getZones().then((zonesFromServer) {
      setState(() {
        global.zones = zonesFromServer;
        global.zones.removeWhere((item) => item.zoneName == null);
      });
    });
    MemberService.getMembers().then((membersFromServer) {
      setState(() {
        global.members = membersFromServer;
        global.members.members.removeWhere((item) => item.firstName == null);
        global.members.members.removeWhere((item) => item.surName == null);
        global.members.members
            .removeWhere((item) => item.branch.branchName == null);
        global.members.members
            .removeWhere((item) => item.zone.zoneName == null);
      });
    });

    DepartmentService.getDepartment().then((deptfromServer) {
      setState(() {
        global.department = deptfromServer;
        global.department.departments
            .removeWhere((item) => item.departmentName == null);
      });
    });

    DiscipleshipStatuservice.getDiscipleshipStatus(
            global.profile.member.branch.branchId)
        .then((trainingfromServer) {
      setState(() {
        global.alltraining = trainingfromServer.trainings;
      });
    });

    BranchHeadService.getBranchHead().then((branchheadFromServer) {
      setState(() {
        global.branchHead = branchheadFromServer;
        global.branchHead.branchHeads
            .removeWhere((item) => item.branch.branchName == null);
      });
    });

    tabcontroller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget carousel = new Container(
      height: 200,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage("assets/dom1.jpg"),
          AssetImage("assets/dom2.jpg"),
          AssetImage("assets/dom3.jpg"),
          AssetImage("assets/dom4.jpg"),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        indicatorBgPadding: 1.0,
        dotColor: Colors.black,
      ),
    );
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.blue.shade900),
        elevation: 30.0,
        backgroundColor: Colors.white,
        title: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 80)),
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
                        '...raising leaders that transform society',
                        style: TextStyle(
                            fontSize: 8,
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
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          Container(
            child: carousel,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.indigo],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20),
              child: Material(
                elevation: 7.0,
                borderRadius: BorderRadius.circular(10.0),
                child: TextField(
                  //  controller: searchController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      //prefixIcon: Icon(Icons.search, color: Colors.red, size: 30.0, ),
                      contentPadding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                      hintText: 'Search All Dominion City Resources...',
                      suffixIcon: InkWell(
                        splashColor: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          // Navigator.of(context).pushNamed('SearchResult');
                          //  List<RatioModel> filteredRatio = List();

                          setState(() {
                            // print(searchController.text);

                            // print(ratios.length);

                            //  ratios.removeWhere((item) => item.heading == null);
                            // ratios.removeWhere((item) => item.suitNo == null);
                            //  ratios.removeWhere((item) => item.body == null);

                            //  filteredRatio = ratios.where((u)=>
                            //  (u.heading.toLowerCase().contains(searchController.text.toLowerCase()))).toList();

                            // print(filteredRatio.length);
                          });

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            //  return SearchResult(filteredRatio,searchController.text, summary);
                          }));
                        },
                        child: Icon(Icons.search),
                      )),

                  /* onChanged: (str){
                          setState(() {
                            searchController.text = str;
                            searchText = str;
                          });
                           
                        },*/
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.indigo],
              ),
            ),
            child: GridView.count(
              crossAxisCount: 3,
              primary: false,
              padding: EdgeInsets.all(30.0),
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              shrinkWrap: true,
              children: <Widget>[
                _buildCard(
                    'Meetings', 'assets/register.png', Meeting(), context),
                _buildCard('News', 'assets/news.png', NewsPage(), context),
                _buildCard('Events', 'assets/events.png', EventPage(), context),
                _buildCard('Department Directory', 'assets/directory.png',
                    DeptDirectorys(), context),
                _buildCard('Prayer Requests', 'assets/prayer.jpg',
                    PrayerRequestPage(), context),
                _buildCard(
                    'Testimony', 'assets/testimony.png', Testimony(), context),
                _buildCard('Devotionals ', 'assets/devotionals.png',
                    DevotionalsPage(), context),
                _buildCard('Music ', 'assets/Music.png', MusicPage(), context),
                _buildCard('Books ', 'assets/book.jpg', BookPage(), context),
                _buildCard('Audio Messages', 'assets/audiomesages2.png',
                    AudioMessagePage(), context),
                _buildCard('DC Airforce TV', 'assets/DcAirforce.png',
                    DCAirforce(), context),
                _buildCard('DC Radio', 'assets/radio.png', DCRadio(), context),
              ],
            ),
          )
        ],
      ),
    );
  }
}

_buildCard(String title, String imgPath, var screen, BuildContext context) {
  return Column(
    children: <Widget>[
      Column(
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(100),
            splashColor: Colors.white,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return screen;
              }));
              //  Navigator.of(context).pushNamed(screen);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 7.5,
              height: MediaQuery.of(context).size.width / 7.5,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(imgPath), fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  boxShadow: [BoxShadow(blurRadius: 20.0, color: Colors.black)]
                  // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid)
                  ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 30,
                fontFamily: 'Monseratti',
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    ],
  );
}
