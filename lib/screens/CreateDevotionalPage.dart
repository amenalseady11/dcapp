import 'package:dcapp/services/DevotionalServe.dart';
import 'package:dcapp/services/EventServe.dart';
import 'package:dcapp/services/NewsServe.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/classes/NewsClass.dart' as news;
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:zefyr/zefyr.dart';
import 'dart:io';
import 'dart:convert';
import 'package:quill_delta/quill_delta.dart';
import 'package:notus/convert.dart';
import 'package:markdown/markdown.dart' as mk;


class CreateDevotionalPage extends StatefulWidget {
  @override
  _CreateDevotionalPageState createState() => _CreateDevotionalPageState();
}

class _CreateDevotionalPageState extends State<CreateDevotionalPage> {

ZefyrController _devotionalBodycontroller;
TextEditingController devotionalTitleController = new TextEditingController();
FocusNode _focusNode;

Future<NotusDocument> _loadDocument() async {
    // final file = File(Directory.systemTemp.path + "/quick_start.json");
    // if (await file.exists()) {
    //   final contents = await file.readAsString();
    //   return NotusDocument.fromJson(jsonDecode(contents));
    // }
    var rawText = global.rawText;
    if(rawText.length > 1){
      setState(() {
          devotionalTitleController.text = global.devotionalTitle;
      });
       
     return NotusDocument.fromJson(jsonDecode(rawText));
    }
    else{
      
      final Delta delta = Delta()..insert("Type Devotionals here...\n");
      return NotusDocument.fromDelta(delta);
      }
  
  }


 void _saveDocument(BuildContext context) async{
  
    final contents = jsonEncode(_devotionalBodycontroller.document);
    
    String html = mk.markdownToHtml(notusMarkdown.encode(_devotionalBodycontroller.document.toDelta()).toString());
    var devotional =html;//
    
      if(global.rawText.length >1){
        await DevotionalService.updateDevotional(devotionalTitleController.text, devotional,  contents, global.devotionaId);
        global.rawText="";
      }else{
        await DevotionalService.postDevotional(devotionalTitleController.text, devotional, DateTime.now(), "Active", 0, contents);
        global.rawText="";
      }
  



   
    // final file = File(Directory.systemTemp.path + "/quick_start.json");
    // // And show a snack bar on success.
    // file.writeAsString(contents).then((_) {
    //   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
    // });
  }

@override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _loadDocument().then((document) {
      setState(() {
        _devotionalBodycontroller = ZefyrController(document);
        if(global.rawText.length >1){
            devotionalTitleController.text = global.devotionalTitle;
        }
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

       final Widget body = (_devotionalBodycontroller == null)
        ? Center(child: CircularProgressIndicator())
        :
        
         ZefyrScaffold(
            child: ZefyrEditor(
              padding: EdgeInsets.all(16),
              controller: _devotionalBodycontroller,
              focusNode: _focusNode,
            ),
          );
    return Scaffold(
      appBar:  new AppBar(iconTheme: new IconThemeData(color: Colors.blue.shade900),
        elevation: 15.0,

        title:Column(children:<Widget>[
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
       actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _displayDialog(context),
            ),
          )
        ],
        
        backgroundColor: Colors.white,

),
 body: body,

      
    );



  }

 _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(' Enter Title'),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
               
               TextField(
        controller: devotionalTitleController,
        decoration: InputDecoration(
            hintText: "Title!",
            border: OutlineInputBorder(),
        ),
      ),
       new RaisedButton(
              color: Colors.blue.shade900,
              child: new Text("Save",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold),),
              onPressed: () {
                  new Future.delayed(Duration.zero, () {
                  loader('Saving Devotionals...');
                
               _saveDocument(context);
                Navigator.pop(context);
                 dialog('Devotionals Saved');
                }

       );
              })]
              )
              
              
              );   
                     
                
          
          
        });
        
        
        
        }






}
