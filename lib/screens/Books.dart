import 'dart:io';


import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dcapp/services/BooksServe.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/classes/BooksClass.dart' as bookClass;
import 'package:intl/intl.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => new _BookPageState();
}

class _BookPageState extends State<BookPage> {
  List<bookClass.Book> _book = List<bookClass.Book>();
  List<bookClass.Book> filteredBooks = List<bookClass.Book>();

  ProgressDialog pr;

  String pathPDF = "";
  String downloadProgress="";

  Future<bool> loader(String str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: ScalingText(str ),
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
  void initState(){
    super.initState();
    new Future.delayed(Duration.zero, () async {
      bool res = await checkconnectivity();
      if (!res) {
        dialog("Internet Required, Check your Network Connection");

        return;
      }
    setState(() {
      new Future.delayed(Duration.zero, () {
        loader(' Loading Book Store...');

        BookService.getBooks().then((bookFromServer) {
          setState(() {
            _book = bookFromServer.books;
            _book.removeWhere((item) => item.description == null);
            _book.removeWhere((item) => item.author == null);
            _book.removeWhere((item) => item.title == null);
            filteredBooks = _book;
            // global.books =bookFromServer.books.cast<bookClass.BooksClass>();

            Navigator.pop(context);
          });
        });
      });
    });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    String dir = (await getExternalStorageDirectory()).path + '/Books';
    String filename = 'book' +
        global.bookId.toString() +
        '.pdf'; // url.substring(url.lastIndexOf("/") + 1);
    if (await File('$dir/$filename').exists()) {
      File file = new File('$dir/$filename');
      pr.hide().then((isHidden) {
          print(isHidden);
          });
      //   await file.writeAsBytes(bytes);
      return file;
    } else {
      final url =
          "http://apekflux-001-site1.btempurl.com/v2/api/books/GetBook?bookid=" +
              global.bookId.toString();


      bool exists = await Directory(dir).exists();

      if (exists) {
       

        Dio dio = new Dio();

        await dio.download(url, '$dir/$filename',
            options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
            onReceiveProgress: (received, total) {
          if (total != -1) {
           
                downloadProgress =(received / total * 100).toStringAsFixed(0) ;
                
                pr.update(
                progress: double.parse(downloadProgress),
                message: "Please wait...",
                progressWidget: Container(
                padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
                maxProgress: 100.0,
                progressTextStyle: TextStyle(
                color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
                messageTextStyle: TextStyle(
                color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
                );
           
          }
        });
          File file = new File('$dir/$filename');
           pr.hide().then((isHidden) {
          print(isHidden);
          });
          return file;

      } else {
        Directory directory = await new Directory('$dir').create();
            // The created directory is returned as a Future.
            
          Dio dio = new Dio();

        filename = directory.path + '/book' +
        global.bookId.toString() +
        '.pdf';
          String downloadPath = filename;//'$directory/$filename';
          await dio.download(url, downloadPath,
          
              options:
                  Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
              onReceiveProgress: (received, total) {
            if (total != -1) {
              //setState(() {

                downloadProgress =(received / total * 100).toStringAsFixed(0) ;
                
                pr.update(
                progress: double.parse(downloadProgress),
                message: "Please wait...",
                progressWidget: Container(
                padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
                maxProgress: 100.0,
                progressTextStyle: TextStyle(
                color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
                messageTextStyle: TextStyle(
                color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
                );
             // });
             
            }
          });
          File file = new File(downloadPath);
          pr.hide().then((isHidden) {
          print(isHidden);
          });
          return file;
        
      }
    }
  }

  

  bookitems() {
    return Column(children: <Widget>[]);
  }

  

  String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MMM-dd');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
  }

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: true);
    pr.style(
      message: 'Downloading file...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
      color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );


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
                      Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40)),
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
                              fontSize: 9,
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
        body: ListView(
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
                              hintText: 'Search Books...'),
                          onChanged: (string) {
                            setState(() {
                              filteredBooks = _book
                                  .where((u) => (u.title
                                          .toString()
                                          .toLowerCase()
                                          .contains(string.toLowerCase()) ||
                                      (u.description
                                              .toLowerCase()
                                              .contains(string.toLowerCase()) ||
                                          (u.amount
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  string.toLowerCase())))))
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
            SizedBox(height: 15.0),
            GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: filteredBooks.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemBuilder: (BuildContext context, int index) {
                  global.bookId = filteredBooks[index].bookId;
                  return Column(children: <Widget>[
                    _buildFoodCard(
                        filteredBooks[index].title,
                        filteredBooks[index].author,
                        index,
                        filteredBooks[index].bookId),
                  ]);
                }),
            SizedBox(height: 10.0)
          ],
        ));
  }

  Widget _buildFoodCard(
      String title, String amount, int cardIndex, int bookid) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0, left: 15),
      child: Container(
        height: MediaQuery.of(context).size.height/3.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
                color: Colors.blue.withOpacity(0.7),
                style: BorderStyle.solid,
                width: 1.0)),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                  height: 140.0,
                  child: CachedNetworkImage(
                    imageUrl:
                        'http://apekflux-001-site1.btempurl.com/v2/api/books/GetThumbnail?bookId=' +
                            bookid.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter:
                              ColorFilter.mode(Colors.blue, BlendMode.dstIn),
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                      ),
                    ),
                    placeholder: (context, url) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    amount,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 12.0,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 110.0,
              top: 102.0,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue),
                child: Center(
                  child: IconButton(
                    icon: new Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: ()async {
                       bool res = await checkconnectivity();
                        if (!res) {
                         dialog("Internet Required, Check your Network Connection");
                          return;
                           }
                      global.bookId = filteredBooks[cardIndex].bookId;
                      global.bookTitle = filteredBooks[cardIndex].title;

                        pr.show();
                        createFileOfPdfUrl().then((f) {
                          setState(() {
                            pathPDF = f.path;
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PDFScreen(pathPDF);
                            }));
                          });
                       
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
