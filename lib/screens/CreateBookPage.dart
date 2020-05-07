import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/classes/BooksClass.dart' as books;
import 'package:flutter/material.dart';
import 'package:dcapp/services/BooksServe.dart';

class CreateBookPage extends StatefulWidget {
  @override
  _CreateBookPage createState() => _CreateBookPage();
}

class _CreateBookPage extends State<CreateBookPage> {
  List<books.Book> _book = List<books.Book>();
  List<books.Book> filteredBooks = List<books.Book>();

  List<String> _marital = ['Commercial', 'Free'];
  String _selectedStatus;

  File _image;
  File _file;
  var bookfile;

  TextEditingController _authorController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  TextEditingController _urlController = new TextEditingController();

  String author;
  String title;
  String description;
  String ctegory;
  String amount;
  String url;

  int serverResponse;
  var filepath;
  var bookPath;

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
          backgroundColor: Colors.white,
        ),
        body: ListView(children: <Widget>[
          new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: new Column(children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 35.00, left: 20.0, right: 20.0, bottom: 50),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            labelText: 'Book Title',
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
                          hintText: "Book Description!",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: _authorController,
                        decoration: InputDecoration(
                            labelText: 'Author',
                            labelStyle: TextStyle(
                                fontFamily: 'MontSerrat',
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButton(
                        hint: Text('Category'), // Not necessary for Option 1
                        value: _selectedStatus,

                        onChanged: (newValue) {
                          setState(() {
                            _selectedStatus = newValue;
                          });
                        },
                        items: _marital.map((marital) {
                          return DropdownMenuItem(
                            child: new Text(marital),
                            value: marital,
                          );
                        }).toList(),
                        isExpanded: true,
                        style: TextStyle(
                            fontFamily: 'Monserrati',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black54),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: _amountController,
                              decoration: InputDecoration(
                                  labelText: 'Amount',
                                  labelStyle: TextStyle(
                                      fontFamily: 'MontSerrat',
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
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
                               if(image!=null){
                                  setState(() {
                                    _image = image;
                                    filepath = image.path;
                                  });
                               }
                                  
                                },
                                child: Center(
                                  child: Text(
                                    'Select Book Cover',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ))),
                      SizedBox(height: 20),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: _image == null
                            ? Text('No cover selected')
                            : Image.file(_image),
                      ),
                      SizedBox(height: 20),
                      Container(
                          height: 40.0,
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.black,
                              color: Colors.blue.shade900,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () async {
                                  var file = await FilePicker.getFile();
                                  setState(() {
                                    _file = file;
                                    bookPath = file.path;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'Select Book',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ))),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: _file == null
                            ? Text('No book selected')
                            : Text(_file.path),
                      ),
                      GestureDetector(
                        onTap: (){
                             new Future.delayed(Duration.zero, () {
                                      loader('Posting Book...');
                                      BookService.postBook(
                                              _titleController.text,
                                              _descriptionController.text,
                                              _authorController.text,
                                              DateTime.now(),
                                              _selectedStatus,
                                              _amountController.text,
                                              "test.url",
                                              "Active",
                                              "test.url",
                                              bookPath,
                                              filepath)
                                          .then((responseFromServer) {
                                        setState(() {
                                          serverResponse = responseFromServer;
                                          if (serverResponse != null) {
                                            BookService.getBooks()
                                                .then((eventsFromServer) {
                                              setState(() {
                                                _book = eventsFromServer.books;
                                                _book.removeWhere((item) =>
                                                    item.description == null);
                                                _book.removeWhere(
                                                    (item) => item.title == null);
                                                _book.removeWhere((item) =>
                                                    item.category == null);
                                                _book.removeWhere((item) =>
                                                    item.thumbnail == null);
                                                _book.removeWhere((item) =>
                                                    item.author == null);
                                                filteredBooks = _book;
                                              });
                                              
                                              Navigator.pop(context);
                                              dialog('Book Posted');
                                            });
                                          }
                                        });
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'MontSerrat'),
                                    ),
                                  ),
                                ))),
                      ),
                    ]))
              ]))
        ]));
  }
}
