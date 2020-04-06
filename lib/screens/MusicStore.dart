import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//import 'package:progress_indicators/progress_indicators.dart';


class Music extends StatefulWidget{
 // final int subId;
 
  @override
  _Music createState() => _Music();

}

class Debouncer{
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.milliseconds});

  run(VoidCallback action){
    if (null != _timer){
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

}
class _Music extends State<Music>{
 

  final _debouncer = Debouncer(milliseconds: 500);

  //List<PrincipleList> principles = List();
  //List<PrincipleList> filteredprinciples = List();

  Future<bool> loader(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
         // title: ScalingText("Loading..."),
        ));
  }


  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      loader();
     // Services.getPrinciple(subId).then((principlesFromServer) {
        setState(() {
       //   principles = principlesFromServer;
        //  filteredprinciples = principles;
          Navigator.pop(context);
        });
     // });

    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Manage  Music Store', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),
          actions: <Widget>[

            new IconButton(icon: new Icon(Icons.add,color: Colors.white,),onPressed: null,),

          ],
          backgroundColor: Colors.blue.shade900,

        ),
        body:
        Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Search Music...'
              ),
             
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  //itemCount: filteredprinciples.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      splashColor: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                           // return RelatedCases(filteredprinciples[index].id);
                          }));
                        });
                      },

                      child:  Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             // Text(filteredprinciples[index].name, style: TextStyle(
                                //  fontSize: 15.0,
                                //  fontFamily: 'Monseratti'

                             // ),),

                            ],
                          ),
                        ),
                      )
                      ,
                    );

                  }),
            )
          ],
        )
    );
  }


}


