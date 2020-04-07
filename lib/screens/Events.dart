import 'dart:io';

import 'package:dcapp/services/EventServe.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/classes/EventsClass.dart' as events;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => new _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<events.Event> even = List<events.Event>();
  List<events.Event> filteredEvents = List<events.Event>();

  String title;
  DateTime eventDate;
  DateTime eventTime;
  String venue;
  String description;

  int serverResponse;
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
                GestureDetector(
                   onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                  child: Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blue.shade900,
                        color: Colors.blue.shade900,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'Back to List',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontSerrat'),
                          ),
                        )),
                  ),
                ),
              ],
            )));
  }
  Future<bool> checkconnectivity() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }else{
         return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }



  @override
  void initState() {
    super.initState();
     new Future.delayed(Duration.zero, () async {
      bool res = await checkconnectivity();
      if (!res) {
        dialog("Internet Required, Check your Network Connection");

        return;
      }
    setState(() {
      new Future.delayed(Duration.zero, () {
        loader(' Loading  Events ...');

        EventService.getEvents().then((eventsFromServer) {
          
          setState(() {
            even = eventsFromServer.events;
            even.removeWhere((item) => item.description == null);
            even.removeWhere((item) => item.venue == null);
            even.removeWhere((item) => item.title == null);
            filteredEvents = even;
            

            Navigator.pop(context);
          });
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
                            hintText: 'Search Events...'),
                        onChanged: (string) {
                          setState(() {
                            filteredEvents = even
                                .where((u) => (u.title
                                        .toString()
                                        .toLowerCase()
                                        .contains(string.toLowerCase()) ||
                                    (u.description
                                            .toLowerCase()
                                            .contains(string.toLowerCase()) ||
                                        (u.eventDate
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                    string.toLowerCase()) ||
                                            (u.venue.toLowerCase().contains(
                                                string.toLowerCase()))))))
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
                itemCount: filteredEvents.length,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width/2.8,
                                        height: 100.0,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'http://apekflux-001-site1.btempurl.com/v2/api/events/GetFile?eventId=' +
                                                  filteredEvents[index]
                                                      .eventId
                                                      .toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.blue,
                                                      BlendMode.dstIn),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 20.0,
                                                      color: Colors.black),
                                                ]),
                                          ),
                                          placeholder: (context, url) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                child:
                                                    CircularProgressIndicator(),
                                                height: 50,
                                                width: 50,
                                              ),
                                            ],
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.only(left: 20),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: new Text(
                                              filteredEvents[index].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )),
                                        SizedBox(height: 6),
                                        Container(
                                            padding: EdgeInsets.only(left: 20),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.grey,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                new Text(
                                                  getDate(filteredEvents[index]
                                                          .eventDate)
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )),
                                        SizedBox(height: 15),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: new Text(
                                                  filteredEvents[index]
                                                      .description,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ))),
                                        SizedBox(height: 20),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: new Text(
                                                  
                                                  getEventsDate(
                                                    filteredEvents[
                                                                  index]
                                                              .eventDate)
                                                          .toString() +
                                                      " day(s) to go!",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))),
                                        SizedBox(height: 20),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.add_location,
                                                      color: Colors.grey,
                                                      size: 15,
                                                    ),
                                                    new Text(
                                                      filteredEvents[index]
                                                          .venue,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ))),
                                      ]),
                                  SizedBox(width: 20),
                                  SizedBox(height: 30),
                                  Row(children: <Widget>[
                                    // Text(getDate(filteredPrayerRequest[index].dateRequested).toString() ,
                                    //        style: TextStyle(
                                    //             fontSize: 14.0,
                                    //            color: Colors.grey,
                                    //            fontFamily: 'Monseratti'

                                    //        ),),
                                  ]),

                                  //second Column
                                ],
                              ),
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
  

