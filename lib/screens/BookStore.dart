import 'package:dcapp/screens/CreateBookPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dcapp/services/BooksServe.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:dcapp/classes/BooksClass.dart' as bookClass;
import 'package:intl/intl.dart';

class BookStore extends StatefulWidget {
  @override
  _BookStoreState createState() => new _BookStoreState();
}

class _BookStoreState extends State<BookStore> {

List<bookClass.Book> _book = List<bookClass.Book>();
List<bookClass.Book> filteredBooks = List<bookClass.Book>();




 @override
  void initState() {
    super.initState();
    setState(() {
      new Future.delayed(Duration.zero, () {
                  loader(' Loading Book Store...');

      BookService.getBooks()
            .then((bookFromServer) {
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
  }
  Future<bool> loader(String str){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText(str),
        ));
  }

bookitems(){

  return Column(children:<Widget>[

  ]);
  
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
     String getDate(DateTime date) {
    var formatdateposted = new DateFormat('yyyy-MMM-dd');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
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
           actions: <Widget>[

                     new IconButton(icon: new Icon(Icons.add,color: Colors.blue.shade900,),onPressed: (){ 
               Navigator.push(context, MaterialPageRoute(builder: (context){
                                return CreateBookPage();
                            }));},),


          ],
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
                       padding: EdgeInsets.only(left:20, right:20),
                       child: Material(
                          elevation: 7.0,
                        borderRadius: BorderRadius.circular(100.0),
                         child: TextField(
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Search Books...'
                    ),
                    onChanged: (string){

                    setState(() {
                    filteredBooks = _book.where((u)=>
                    (u.title.toString().toLowerCase().contains(string.toLowerCase())||
                    (u.description.toLowerCase().contains(string.toLowerCase())||
                    (u.amount.toString().toLowerCase().contains(string.toLowerCase())
                   )))).toList();
                    });


            },
            ),
                       ),
                     ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  ],
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.8),
      itemBuilder: (BuildContext context, int index){
          return Column(children: <Widget>[
          _buildFoodCard(filteredBooks[index].title, filteredBooks[index].author, index,filteredBooks[index].bookId )

          ]);

           }
          ),
          SizedBox(height: 10.0)
        ],
      )
    );
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
                    onPressed: () {
                     
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