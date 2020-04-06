import 'package:dcapp/classes/AttendaceClass.dart';
import 'package:dcapp/classes/AttendanceClass2.dart';
import 'package:dcapp/classes/PrayerRequestClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;

class PostPrayerRequestService{

  
  static Future <PrayerRequestClass> getPrayerRequest(int memberID) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/PrayerRequests/GetPrayerRequestByBranch?branchId=' + memberID.toString();;
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        PrayerRequestClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> savePrayerRequest(int memberID, int branchID,   DateTime date, String request) async{
       String url =   'http://apekflux-001-site1.btempurl.com/v2/api/PrayerRequests';
    try{

       String daterequestedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(date);
      daterequestedStr = formateddateposted.toString();


    



      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'branchId': branchID, 'memberId': memberID,'request': '$request', 'dateRequested': '$daterequestedStr',  'status': 'Active' }));
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

  static int getResponse(String responseBody){
    int data;
    data = json.decode(responseBody)["id"];
    return data;
  }
  static PrayerRequestClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final prayerRequestClass = prayerRequestClassFromJson(responseBody);
   return prayerRequestClass;
  }
}