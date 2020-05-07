import 'package:dcapp/services/DevotionalServe.dart';
import 'package:flutter/material.dart';
import 'package:dcapp/classes/DevotionalCommentClass.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:html/parser.dart';

class ReadDevotionalPage extends StatefulWidget {
  @override
  _ReadDevotionalPageState createState() => _ReadDevotionalPageState();
}

class _ReadDevotionalPageState extends State<ReadDevotionalPage> {

  DevotionalCommentClass devComment = new DevotionalCommentClass();
  List<DevotionalComment> _comments = new List<DevotionalComment>();

  TextEditingController commentController = new TextEditingController();
   ScrollController _scrollController = new ScrollController();
  int likeCount = 0;

    String parsehtml(String str){

      var document = parse(str);
      String parseString = parse(document.body.text).documentElement.text;
      return parseString;
    }


  updateDevotionalLikeCount() {
    DevotionalService.updateDevotionalLikeCount(global.devotionaId);
    setState(() {
      likeCount++;
    });
  }


   String getDate(DateTime date) {
    var formatdateposted = new DateFormat('MMMM, dd yyyy, hh mm');
    String formateddateposted = formatdateposted.format(date);
    return formateddateposted.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      DevotionalService.getDevotionalLikeCount(global.devotionaId)
          .then((likeCountFromServer) {
        setState(() {
          likeCount = likeCountFromServer;
        });
      });
    });
    DevotionalService.getDevotionalComment(global.devotionaId)
        .then((commentfromserver) {
      setState(() {
        _comments = commentfromserver.devotionalComments;
      });
    });
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
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share),  onPressed: () {
                                 
                                  Share.share(parsehtml(global.devotionalBody.toString()) );
                                     },)
        ],
        backgroundColor: Colors.white,
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
        
        Expanded(
          // width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.only(top: 20, left: 30),
          child: ListView.builder(
             reverse: true,
             controller: _scrollController,
             shrinkWrap: true,
             padding: EdgeInsets.all(10.0),
                  itemCount:1,
                  itemBuilder: (BuildContext context, int index){
                    return Column(children:<Widget>[
                      Text(
                            global.devotionalTitle,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                          ),
                          SizedBox(height:10),
                          Text(
                        ' Published' + " " + global.devotionalDate.toString(),
                          textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
 Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: <Widget>[
            Html(
              data: global.devotionalBody,
              padding: EdgeInsets.all(8.0),
              linkStyle: const TextStyle(
                color: Colors.redAccent,
                decorationColor: Colors.redAccent,
                decoration: TextDecoration.underline,
              ),
              onLinkTap: (url) {
                print("Opening $url...");
              },
              onImageTap: (src) {
                print(src);
              },
              //Must have useRichText set to false for this to work
              customRender: (node, children) {
                if (node is dom.Element) {
                  switch (node.localName) {
                    case "custom_tag":
                      return Column(children: children);
                  }
                }
                return null;
              },
              customTextAlign: (dom.Node node) {
                if (node is dom.Element) {
                  switch (node.localName) {
                    case "p":
                      return TextAlign.justify;
                  }
                }
                return null;
              },
              customTextStyle: (dom.Node node, TextStyle baseStyle) {
                if (node is dom.Element) {
                  switch (node.localName) {
                    case "p":
                      return baseStyle
                          .merge(TextStyle(height: 2, fontSize: 20));
                  }
                }
                return baseStyle;
              },
            )
          ]),
        ),

                  Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.all(0.0),
                  itemCount: _comments.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      splashColor: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: (){
                        setState(() {
                          
                        });
                      },

                      child:   Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: 
                          
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                     Container(
                    width: 50.0,
                    height: 50.0,



                    child: CachedNetworkImage(
                imageUrl: 'http://apekflux-001-site1.btempurl.com/v2/api/members/GetFile?memberId=' +_comments[index].member.memberId.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      
                      colorFilter: ColorFilter.mode(
                        Colors.blue,
                        BlendMode.dstIn
                      ),
                    ),
                     borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 20.0, color: Colors.black),
                    ]
                  ),
                ),
                placeholder: (context, url) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(child:CircularProgressIndicator(),height: 50, width: 50,),
                  ],
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
             
                    ),
                    ],
             ),

                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children:<Widget>[
                                      Container(
                                         padding: EdgeInsets.only(left: 20),
                                          width: MediaQuery.of(context).size.width*0.5,
                                        child: new Text(_comments[index].comment)),
                                          SizedBox(height:6),

                                      Container(
                                        
                                        padding: EdgeInsets.only(left: 20),
                                          width: MediaQuery.of(context).size.width*0.5,
                                        child: Row(
                                          children: <Widget>[
                                             Icon(Icons.calendar_today, color: Colors.grey, size: 15,),
                                             SizedBox(width:5),
                                            new Text(getDate(_comments[index].dateCommented), style: TextStyle(color:Colors.grey),),
                                          ],
                                        )),
                                    
                                     
                                     
                                  
                                      ]),
                             
                                
                                
                                ],
                              ),
                            ],
                          ),
                          
                        ),
                      )
                      
                    );

                  }),
            )
                    ]);

                  }
         
              
            
          ),
        ),
       
      
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: updateDevotionalLikeCount),
                    Text(likeCount.toString())
                  ],
                ),
                SizedBox(
                  child: TextField(
                    controller: commentController,
                    maxLines: 2,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: "Post a comment!",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width / 1.65,
                ),
                new IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      
                      DevotionalService.postDevotionalComment(
                              DateTime.now(),
                              commentController.text,
                              global.profile.member.memberId,
                              global.devotionaId,
                              0,
                              "Active")
                          .then((resrponsefromserver) {
                        var id = resrponsefromserver;
                        DevotionalComment dc = new DevotionalComment();
                        dc.id = id;
                        dc.comment = commentController.text;
                        dc.dateCommented =DateTime.now();
                        dc.likeCount =0;
                        dc.devotional=null;
                        dc.status = 'Active';
                        Member memb = new Member();
                        memb.address = null;
                        memb.anniversary =null;
                        memb.branch = null;
                        memb.city = null;
                        memb.country = null;
                        memb.dateJoined = null;
                        memb.dob =null;
                        memb.emailAddress = null;
                        memb.firstName =null;
                        memb.gender =null;
                        memb.guest =null;
                        memb.invitedBy = null;
                        memb.memberId = global.profile.member.memberId;
                        memb.maritalStatus = null;
                        memb.note = null;
                        memb.phoneNumber = null;
                        memb.pictureUrl = null;
                        memb.state = null;
                        memb.surName = null;
                        memb.zone = null;
                        dc.member =memb;
                        setState(() {
                          _comments.add(dc);
                          commentController.text="";
                        });
                         _scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
