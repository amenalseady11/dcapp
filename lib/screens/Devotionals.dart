
import 'package:dcapp/screens/ReadDevotionalPage.dart';
import 'package:dcapp/services/DevotionalServe.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/classes/DevotionalsClass.dart' as devot;
import 'package:dcapp/globals.dart' as global;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

class DevotionalsPage extends StatefulWidget {
  @override
  _DevotionalsPageState createState() => new _DevotionalsPageState();
}

class _DevotionalsPageState extends State<DevotionalsPage> {

    List<devot.Devotional> _devotionals = List<devot.Devotional>();
    List<devot.Devotional> filteredDevotionals = List<devot.Devotional>();

  // List<news.News> _news = List<news.News>();
  // List<news.News> filteredNews = List<news.News>();
  
  int count =0; 

  

  @override
  void initState() {
    super.initState();
    setState(() {
      new Future.delayed(Duration.zero, () {
        loader(' Loading  Devotionals ...');

        DevotionalService.getDevotional().then((devotionalFromServer) {
          setState(() {
            _devotionals = devotionalFromServer.devotionals;
            _devotionals.removeWhere((item) => item.title == null);
            _devotionals.removeWhere((item) => item.devotionaltext == null);
            _devotionals.removeWhere((item) => item.datePublished == null);
            filteredDevotionals = _devotionals;
            filteredDevotionals.sort((b, a) => a.datePublished.compareTo(b.datePublished));
            Navigator.pop(context);
          });
        });
      });
    });
  }

  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('MMMM, dd yyyy');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
  }

  String getEventsDate(DateTime event) {
    var date2 = DateTime.now();
    final difference = event.difference(date2).inDays;
    return difference.toString();
  }

  Future<bool> loader(String str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: ScalingText(str),
            ));
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
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.blue.shade900),
        elevation: 15.0,
        title: Column(children: <Widget>[
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
        ]),
        actions: <Widget>[],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 15.0,
            margin: EdgeInsets.only(top: 0),
            child: Container(
              height: 100.0,
              color: Colors.blue.shade900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Material(
                      elevation: 7.0,
                      borderRadius: BorderRadius.circular(100.0),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            hintText: 'Search Devotionals...'),
                        onChanged: (string) {
                          setState(() {
                            filteredDevotionals  = _devotionals
                                .where((u) => (u.datePublished
                                        .toString()
                                        .toLowerCase()
                                        .contains(string.toLowerCase()) ||
                                    (u.title
                                            .toLowerCase()
                                            .contains(string.toLowerCase()) ||
                                        (u.devotionaltext
                                            .toString()
                                            .toLowerCase()
                                            .contains(string.toLowerCase())))))
                                .toList();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: filteredDevotionals.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {});
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: 
                          
                          Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.only(left:18.0),
                                   child: 
                                   Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       
                                       Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                         children: <Widget>[
                                           Row(
                                             children: <Widget>[
                                               Container(
                                                 width: MediaQuery.of(context).size.width/1.5,
                                                 child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: <Widget>[
                                                     Text(filteredDevotionals[index].title , 
                                                     style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.bold,
                                                         fontFamily: 'Monseratti'

                                                     ),),
                                                   ],
                                                 ),
                                               ),
                                               

                                             ],
                                             
                                           ),
                                           SizedBox(height:10),
                                          
                                         ],
                                       ),
                                      
                                     
                                     ],
                                   ),
                                  
                                 ),
                                 
                                 SizedBox(height:2),
                                   Padding(
                                     padding: const EdgeInsets.only(top:1, left:18),
                                     child: Row(
                                       children: <Widget>[
                                         Icon(Icons.timer,size: 15, color:Colors.grey),
                                         Text(getDate(
                                                    filteredDevotionals[index].datePublished)),
                                         
                                         SizedBox(width:3),
                                         
                                         SizedBox(width: 20),
                                          Icon(Icons.thumb_up, color:Colors.grey , size: 15,),
                                         Text(filteredDevotionals[index].likeCount.toString()),
                                         
                                         
                                         
                                       ],
                                     ),

                                     
                                   ),
                                  
                                 

                                ],
                              ),


                              Spacer(),
                             Column(
                               children:<Widget>[
                                   new IconButton
                              (
                                padding: EdgeInsets.only(left:0),
                                icon: Icon(Icons.arrow_right, size: 50,),
                               onPressed: () {
                                 global.devotionaId = filteredDevotionals[index].id;
                                   Navigator.push(context, MaterialPageRoute(builder: (context){
                                   
                                      global.devotionalTitle = filteredDevotionals[index].title;
                                      global.devotionalBody = filteredDevotionals[index].devotionaltext;
                                      global.devotionalDate = getDate(filteredDevotionals[index].datePublished);
                                return ReadDevotionalPage();
                                     }));
              },
                              ),
                              Row(
                               children: <Widget>[
                                // Text( filteredDisciple[index])
                               ],
                              ),
                                  ])
                            ],
                          ),
                          
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
