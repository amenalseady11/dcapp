import 'package:dcapp/screens/NewsViewPage.dart';
import 'package:dcapp/services/NewsServe.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/classes/NewsClass.dart' as news;
import 'package:dcapp/globals.dart' as global;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  List<news.News> _news = List<news.News>();
  List<news.News> filteredNews = List<news.News>();
  
  int count =0; 

  

  @override
  void initState() {
    super.initState();
    setState(() {
      new Future.delayed(Duration.zero, () {
        loader(' Loading  News ...');

        NewsService.getNews().then((newsFromServer) {
          setState(() {
            _news = newsFromServer.news;
            _news.removeWhere((item) => item.headline == null);
            _news.removeWhere((item) => item.newsDescription == null);

            filteredNews = _news;

            Navigator.pop(context);
          });
        });
      });
    });
  }

  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MMM-dd');
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
                              fontSize: 12,
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
                            hintText: 'Search News...'),
                        onChanged: (string) {
                          setState(() {
                            filteredNews = _news
                                .where((u) => (u.datePosted
                                        .toString()
                                        .toLowerCase()
                                        .contains(string.toLowerCase()) ||
                                    (u.headline
                                            .toLowerCase()
                                            .contains(string.toLowerCase()) ||
                                        (u.newsDescription
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
                itemCount: filteredNews.length,
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
                                               Column(
                                                 children: <Widget>[
                                                   Text(filteredNews[index].headline , 
                                                   style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight: FontWeight.bold,
                                                       fontFamily: 'Monseratti'

                                                   ),),
                                                 ],
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
                                         Text(getDate(
                                                    filteredNews[index].datePosted)),
                                         
                                         SizedBox(width:3),
                                         Icon(Icons.timer,size: 15, color:Colors.grey),
                                         SizedBox(width: 20),
                                          Icon(Icons.remove_red_eye, color:Colors.grey , size: 15,),
                                         Text(filteredNews[index].viewCount.toString()),
                                    
                                         
                                         
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
                                 global.newsId = filteredNews[index].id;
                                   Navigator.push(context, MaterialPageRoute(builder: (context){
                                     NewsService.updateNewsCount(global.newsId);
                                      global.newsDetail = filteredNews[index].newsDescription;
                                      global.newsHeadline = filteredNews[index].headline;
                                      
                                return NewsDetailsPage();
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
