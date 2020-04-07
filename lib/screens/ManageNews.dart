import 'package:dcapp/screens/NewsCreatingPage.dart';
import 'package:dcapp/screens/NewsViewPage.dart';
import 'package:dcapp/services/NewsServe.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/classes/NewsClass.dart' as news;
import 'package:dcapp/globals.dart' as global;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';





class ManageNews extends StatefulWidget{
  @override
  _ManageNews createState() => _ManageNews();

}


class _ManageNews extends State<ManageNews>{

List<news.News> _news = List<news.News>();
List<news.News> filterednews = List<news.News>();


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


  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MMM-dd');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
  }


String getEventsDate(DateTime event){
 
 var date2 = DateTime.now();
 final difference = event.difference(date2).inDays;
 return difference.toString();
}




DateTime _eventsdate = new DateTime(2020);
Future<DateTime> _selectEventDate(BuildContext context) async{
  final DateTime picked = await showDatePicker(
    context: context, 
    initialDate: _eventsdate, 
    firstDate: new DateTime(1900), 
    lastDate: new DateTime.now()
    );
    if(picked !=null && picked != _eventsdate){
      print('Date Selected: ${_eventsdate.toString()}');
      setState(() {
        _eventsdate = picked;

        var formatter = new DateFormat('yyyyy-MM-dd');
        String formatted = formatter.format(_eventsdate);
        
        _eventsDateController.text = formatted.toString();
        
      });
    }
}
TimeOfDay _time = new TimeOfDay.now();

 Future<Null> _eventTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if(picked != null && picked != _time) {
      print('Time selected: ${_time.toString()}');
      setState((){
        _time = picked;
        _timeController.text = _time.toString();
      });
    }
  }




  @override
  void initState() {
    super.initState();
    setState(() {
      new Future.delayed(Duration.zero, () {
                  loader(' Loading News List...');

      NewsService.getNews()
            .then((newsFromServer) {
          setState(() {
            _news = newsFromServer.news;
            _news.removeWhere((item) => item.headline == null);
            _news.removeWhere((item) => item.newsDescription == null);
           

            filterednews = _news;

            Navigator.pop(context);
          });
        });
      });

   });
  }
    
   
  Future<bool> loader(String str){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText(str),
        ));
  }

  Future<bool> dialog(str){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title:Text('Message') ,
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(str, style: TextStyle(
          fontSize: 14,
          color: Colors.blue.shade900

        ),),
        SizedBox(height: 10.0,),
        GestureDetector(
           onTap: (){
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
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                          )
                      ),

                    ),
        ),
        ],) 
        
      ));
    }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Manage  News', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),
          actions: <Widget>[

            new IconButton(icon: new Icon(Icons.add,color: Colors.white,),onPressed: (){ 
               Navigator.push(context, MaterialPageRoute(builder: (context){
                                return NewsCreatingPage();
                            }));},),

          ],
          backgroundColor: Colors.blue.shade900,

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

                      Text('Number of News', style: TextStyle(color: Colors.white),),
                    ],),
                      SizedBox(height:5),
                     Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(filterednews.length.toString(), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                    hintText: 'Search Events...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filterednews = _news.where((u)=>
                    (u.headline.toLowerCase().contains(string.toLowerCase()))||
                    (u.newsDescription.toString().toLowerCase().contains(string.toLowerCase()))
                    ).toList();
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
                padding: EdgeInsets.all(0.0),
                itemCount: filterednews.length,
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
                                                   Text(filterednews[index].headline , 
                                                   style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight: FontWeight.bold,
                                                       fontFamily: 'Monseratti'

                                                   ),),
                                                 ],
                                               ),
                                               SizedBox(width: 20),

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
                                     padding: const EdgeInsets.all(18.0),
                                     child: Row(
                                       children: <Widget>[
                                         Text(getDate(
                                                    filterednews[index].datePosted)),
                                         SizedBox(width: 20),
                                         
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
                                 
                                   Navigator.push(context, MaterialPageRoute(builder: (context){
                                    
                                      global.newsDetail = filterednews[index].newsDescription;
                                      global.newsHeadline = filterednews[index].headline;
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
                          
          ]),
                      );
               
  }


}




