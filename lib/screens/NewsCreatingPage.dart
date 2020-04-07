import 'package:dcapp/services/EventServe.dart';
import 'package:dcapp/services/NewsServe.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/classes/NewsClass.dart' as news;
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;




class NewsCreatingPage extends StatefulWidget{
  @override
  _NewsCreatingPage createState()=> _NewsCreatingPage();

}


class _NewsCreatingPage extends State<NewsCreatingPage> {

List<news.News> _news = List<news.News>();
List<news.News> filterednews = List<news.News>();


TextEditingController _eventsDateController = new TextEditingController();
TextEditingController _titleController = new TextEditingController();
TextEditingController _descriptionController = new TextEditingController();
TextEditingController _venueController = new TextEditingController();
TextEditingController _timeController = new TextEditingController();
  


  
  
  String title;
  DateTime dateposted;
  DateTime eventTime;
  String venue;
  String description;

  int serverResponse;


  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MMM-dd');
    String formateddateposted = formatdateposted.format(date);
    
    return formateddateposted.toString();
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
        Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blue.shade900,
                        color: Colors.blue.shade900,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){
                             Navigator.pop(context);
                             Navigator.pop(context);
                             
                          },
                          child: Center(
                            child: Text(
                              'Back to List',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                          ),
                        )
                    ),

                  ),
        ],) 
        
      ));
    }

    @override
   void initState() {
    super.initState();
    setState(() {
    
     
     
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
                                Padding(padding: EdgeInsets.only(left:30)),
                                Image(image: AssetImage("assets/domcitylogo2.jpg"), width: 50,height: 50),
                               
                              ],
                            ),
                          ],
                        ),
                        Column(
                         
                          children: <Widget>[
                            
                            Row(
                              
                              children: <Widget>[
                               
                                Container(
                                  padding: EdgeInsets.only(top:80),
                                  
                                  
                                  child: new Text('Dominion City',style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.indigo),),
                                ),
                              ],
                            ),
                             Row(
                              
                              children: <Widget>[
                                Container(
                                 
                                  height: 100.0,
                                  
                                  child: new Text('...raising leaders that transforms society',style:TextStyle(fontSize: 8, fontWeight: FontWeight.bold,color: Colors.indigo),),
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
        body: 
       ListView(
         
         children: <Widget>[
           
           new SingleChildScrollView(
             
            scrollDirection: Axis.vertical,
            child: new Column(
              children: <Widget>[
                 
                Container(
                  padding: EdgeInsets.only(top: 35.00, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[

                      Text('News', style: TextStyle(
                        fontFamily: 'Monserrati',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        
                      ),),
                      SizedBox(height: 40,),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            labelText: 'Headline',
                            labelStyle:  TextStyle(
                                fontFamily: 'MontSerrat',
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                       SizedBox(height: 40,),
                       TextField(
        controller: _descriptionController,
        maxLines: 6,
       
        decoration: InputDecoration(
            hintText: "News Description!",
            border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height:6),
                      GestureDetector(
                        onTap: (){
                           new Future.delayed(Duration.zero, () {
                  loader('Creating News...');
                    dateposted = DateTime.now();
                  
                    NewsService.postNews(dateposted, _titleController.text, _descriptionController.text, 'Active', 0).then((responseFromServer) {
                    setState(() {
                    serverResponse = responseFromServer;
                   if(serverResponse !=null){
                          NewsService.getNews()
            .then((newsFromServer) {
          setState(() {
            _news = newsFromServer.news;
            _news.removeWhere((item) => item.headline == null);
            _news.removeWhere((item) => item.newsDescription == null);
            filterednews = _news;
          });
                 Navigator.pop(context);
                    dialog('News  Published');
        });
       }
  }
  );
                   });
             
                 });
                        },
                        child: Container(
                          height: 40.0,
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.black,
                              color: Colors.blue.shade900,
                              elevation: 7.0,
                              child: Center(
                                 child: Text(
                                   'PUBLISH',
                                   style: TextStyle(
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                       fontFamily: 'MontSerrat'
                                   ),
                                 ),
                                 
                               ))),
                      )]
              )
              )
              ]
              )
              )
              ]
              )
              );
  }}