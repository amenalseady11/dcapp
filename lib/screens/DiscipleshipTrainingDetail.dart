import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;
import 'package:url_launcher/url_launcher.dart';

class MemberTraingDetail extends StatefulWidget {
  @override
  _MemberTraingDetailState createState() => _MemberTraingDetailState();
}

class _MemberTraingDetailState extends State<MemberTraingDetail> {
  int index;
  var details = global.members.members
      .where((u) => u.memberId == global.memberId)
      .toList();
  var membertrainings = global.discipletraining
      .where((u) => u.memberId == global.memberId)
      .toList();
  var alltraining = global.alltraining;

  getTrainingStatus(int trainingID, String trainingName) {
    var status = membertrainings[0]
        .training
        .where((e) => e.trainingId == trainingID && e.status == "Done");
    if (status.length > 0) {
      return Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 30,
        runSpacing: 5,
        children: [
          Text(
            trainingName,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monseratti'),
          ),
          Container(
            padding: EdgeInsets.only(top:5),
             height: 25.0,
             width: 100,
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.black,
                            color: Colors.green,
                            elevation: 7.0,
                            child: Text('Completed',textAlign: TextAlign.center,style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold),),
                           )
          )
          
        ],

      );

    } else {
      return Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 30,
        runSpacing: 5,
        children: [
          Text(
            trainingName,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monseratti'),
          ),

          Container(
            padding: EdgeInsets.only(top:5),
             height: 25.0,
             width: 130,
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.black,
                            color: Colors.red,
                            elevation: 7.0,
                            child: Text(' Not Completed',textAlign: TextAlign.center,style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold),),
                           )
          )
        ],

      );

     /* Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                trainingName,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monseratti'),
              ),
            ],
          ),
          Column(
            children: <Widget>[Text('Not Completed')],
          )
        ],
      );*/
    }
  }

  getmemberPhone(int memberId) {
    // membertrainings[0].training.where(test)

    var phone =
        global.members.members.where((u) => u.memberId == memberId).toList();

    if (phone.length <= 0) {
      return Text(
        'Phone Number not available or zone not selected',
        style: TextStyle(color: Colors.red, fontSize: 12),
      );
    }
    return Row(
      children: <Widget>[
        new IconButton(
          padding: EdgeInsets.only(left: 0),
          icon: Icon(
            Icons.call,
            color: Colors.green,
            size: 25,
          ),
          onPressed: () => launch("tel:${phone[0].phoneNumber.toString()}"),
        ),
        Text(
          phone[0].phoneNumber,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(children: <Widget>[
        Card(
          elevation: 15.0,
          margin: EdgeInsets.only(top: 0),
          child: Container(
            height: 150.0,
            color: Colors.blue.shade900,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text( getmemberPhone(memberId), style: TextStyle(color: Colors.white),),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      global.membername,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[getmemberPhone(global.memberId)],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: alltraining.length,
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
                      child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Column(
                                
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                getTrainingStatus(
                                                    alltraining[index]
                                                        .trainingId,
                                                    alltraining[index]
                                                        .trainingName)
                                              ],
                                            ),
                                            SizedBox(width: 20),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ]),
    );
  }
}
