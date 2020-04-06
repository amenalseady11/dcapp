import 'package:dcapp/classes/AttendaceClass.dart';
import 'package:dcapp/classes/AttendanceClass2.dart';
import 'package:dcapp/classes/MeetingClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;

class MeetingService{

  
 
  static Future<MeetingClass> getmeetingStatus(int branchID, String meetingTitle) async {
     String url =
      'http://apekflux-001-site1.btempurl.com/v2/api/meetings/getmeetingstatus?branchid='+ branchID.toString() +'&meetingtitle='+ meetingTitle;
    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        MeetingClass list = parse(response.body);
        return list;
      } else {
       // throw Exception("Error");
      }
    } catch (e) {
     // throw Exception(e.toString());
    }
  }

    static Future<int> postMeeting(
      int branchId ,
      String meetingTitle,
      String meetingtime ,
      String status,
      ) async{
       String url =   'http://apekflux-001-site1.btempurl.com/v2/api/meetings';
    try{

      var meet = DateTime.parse(meetingtime);
      String meetingDateStr;
      var formatdatePosted = new DateFormat('yyyy-MM-dd HH:mm:ss');
      String formateddateposted = formatdatePosted.format(meet);
      meetingDateStr = formateddateposted.toString();
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'branchId': branchId, 'meetingTitle': '$meetingTitle', 'starttime': '$meetingDateStr', 'status': "$status"}));
      if(response.statusCode==200){
      //  print(response.body);

        int resp = getResponse(response.body);
        return resp;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

 static Future<int> getDeactivateMeetingById(int id) async {
    String url =
        ' http://apekflux-001-site1.btempurl.com/v2/api/meetings/DeactivateMeeting?id=' +
            id.toString();

    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        int list = int.parse(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


static Future<MeetingClass> getmeetingbyCategory(String category) async {
    String url =
        'http://apekflux-001-site1.btempurl.com/v2/api/meetings/GetMeetingByCategory?Category=' +
            category;

    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        MeetingClass list = parse(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }




  static int getResponse(String responseBody){
    int data;
    data = json.decode(responseBody)["id"];
    return data;
  }
  static MeetingClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final meetingClass = meetingClassFromJson(responseBody);
   return meetingClass;
  }
}