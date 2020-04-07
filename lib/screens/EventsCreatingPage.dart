import 'package:dcapp/services/EventServe.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/classes/EventsClass.dart' as events;
import 'package:flutter/material.dart';

class EventsCreatingPage extends StatefulWidget {
  @override
  _EventsCreatingPage createState() => _EventsCreatingPage();
}

class _EventsCreatingPage extends State<EventsCreatingPage> {
  List<events.Event> even = List<events.Event>();
  List<events.Event> filteredEvents = List<events.Event>();
  File _image;

  TextEditingController _eventsDateController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _venueController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();

  String title;
  DateTime eventDate;
  DateTime eventTime;
  String venue;
  String description;

  int serverResponse;
  var filepath;

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

  DateTime _eventsdate = new DateTime(2020);
  Future<DateTime> _selectEventDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _eventsdate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2099));
    if (picked != null && picked != _eventsdate) {
      print('Date Selected: ${_eventsdate.toString()}');
      setState(() {
        _eventsdate = picked;

        var formatter = new DateFormat('yyyy-MM-dd');
        String formatted = formatter.format(_eventsdate);

        _eventsDateController.text = formatted.toString();
      });
    }
  }

  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _eventTime(BuildContext context) async {
     TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null && picked != _time) {
      // print('Time selected: ${_time.toString()}');
      setState(() {
        _time = picked;
        _timeController.text = _time.format(context);
      });
    }
  }

  events.EventsClass _eventsClass = new events.EventsClass();
  var filteredevents = List();

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

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                        Padding(padding: EdgeInsets.only(left: 30)),
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
          backgroundColor: Colors.white,
        ),
        body: ListView(children: <Widget>[
          new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: new Column(children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
                    child: Column(children: <Widget>[
                      Text(
                        'Events Form',
                        style: TextStyle(
                          fontFamily: 'Monserrati',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            labelText: 'Events Title',
                            labelStyle: TextStyle(
                                fontFamily: 'MontSerrat',
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: "Events Description!",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: _venueController,
                        decoration: InputDecoration(
                            labelText: 'Venue',
                            labelStyle: TextStyle(
                                fontFamily: 'MontSerrat',
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextFormField(
                          controller: _eventsDateController,
                          decoration: InputDecoration(
                              labelText: 'Events Date',
                              labelStyle: TextStyle(
                                  fontFamily: 'MontSerrat',
                                  fontWeight: FontWeight.bold)),
                          onTap: () {
                            _selectEventDate(context);
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: _timeController,
                              decoration: InputDecoration(
                                  labelText: 'Events Time',
                                  labelStyle: TextStyle(
                                      fontFamily: 'MontSerrat',
                                      fontWeight: FontWeight.bold)),
                              onTap: () {
                                _eventTime(context);
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.0),
                      //_addSecondDropdown(),
                      Container(
                          height: 40.0,
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.black,
                              color: Colors.blue.shade900,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () async {
                                  var image = await ImagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    _image = image;
                                    filepath = image.path;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'Select Banner',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ))),

                      SizedBox(height: 20),

                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: _image == null
                            ? Text('No banner selected')
                            : Image.file(_image),
                      ),

                      //_addSecondDropdown(),

                      SizedBox(height: 20.0),

                      Container(
                          height: 40.0,
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.black,
                              color: Colors.blue.shade900,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () {
                                  //save to server
                                  new Future.delayed(Duration.zero, () {
                                    loader('Creating Event...');

                                    EventService.postEvent(
                                            DateTime.parse(
                                                _eventsDateController.text),
                                            _timeController.text,
                                            _titleController.text,
                                            _descriptionController.text,
                                            _venueController.text,
                                            'bannerurl',
                                            'Active',
                                            filepath)
                                        .then((responseFromServer) {
                                      setState(() {
                                        serverResponse = responseFromServer;
                                        if (serverResponse != null) {
                                          EventService.getEvents()
                                              .then((eventsFromServer) {
                                            setState(() {
                                              even = eventsFromServer.events;
                                              even.removeWhere((item) =>
                                                  item.description == null);
                                              even.removeWhere(
                                                  (item) => item.venue == null);
                                              even.removeWhere(
                                                  (item) => item.title == null);

                                              filteredEvents = even;
                                            });
                                            Navigator.pop(context);
                                            dialog('Events Saved');
                                          });
                                        }
                                      });
                                    });
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'SUBMIT',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'MontSerrat'),
                                  ),
                                ),
                              )))
                    ]))
              ]))
        ]));
  }
}
