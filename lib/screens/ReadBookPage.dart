import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_indicators/progress_indicators.dart';


class ReadBook extends StatefulWidget {
  @override
  _ReadBookState createState() => new _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  int count;

  
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

  String pathPDF = "";
  @override
  void initState() {
    super.initState();

    new Future.delayed(Duration.zero, () {
      loader('Downloading......');

      createFileOfPdfUrl().then((f) {
        setState(() {
          pathPDF = f.path;
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PDFScreen(pathPDF);
          }));
        });
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    String dir = (await getExternalStorageDirectory()).path + '/Books';
    final filename = 'book' +
        global.bookId.toString() +
        '.pdf'; // url.substring(url.lastIndexOf("/") + 1);
    if (await File('$dir/$filename').exists()) {
      File file = new File('$dir/$filename');

      //   await file.writeAsBytes(bytes);
      return file;
    } else {
      final url =
          "http://apekflux-001-site1.btempurl.com/v2/api/books/GetBook?bookid=" +
              global.bookId.toString();

      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();

      var bytes = await consolidateHttpClientResponseBytes(response);

      bool exists = await Directory(dir).exists();

      if (exists) {
       
          File file = new File('$dir/$filename');

          await file.writeAsBytes(bytes);
          return file;
        
      } else {
        new Directory('$dir').create()
            // The created directory is returned as a Future.
            .then((Directory directory) async {
          print('New Directory Created');
          File file = new File('$directory/$filename');

          await file.writeAsBytes(bytes);
          return file;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        ]),
        actions: <Widget>[],
        backgroundColor: Colors.white,
        
      ),
      body: Container()
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
         
  
          title: Text(global.bookTitle),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}

class Downloads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(title: Text(global.bookTitle)),
    );
  }
}
