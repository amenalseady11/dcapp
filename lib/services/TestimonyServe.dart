import 'package:dcapp/classes/AttendaceClass.dart';
import 'package:dcapp/classes/AttendanceClass2.dart';
import 'package:dcapp/classes/PrayerRequestClass.dart';
import 'package:dcapp/classes/TestimonyClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;

class TestimonyService{

  
  static Future <TestimoniesClass> getTestimony(int memberID) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/Testimonies/GetTestimoniesByMemberID?memberId=' + memberID.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        TestimoniesClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }


   static Future <TestimoniesClass> getTestimonyByBranch(int branchID) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/Testimonies/GetTestimoniesByBranch?branchid=' + branchID.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        TestimoniesClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveTestimony(int memberID, DateTime date, String testimony) async{
       String url =   'http://apekflux-001-site1.btempurl.com/v2/api/Testimonies';
    try{

       String datesubmittedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(date);
      datesubmittedStr = formateddateposted.toString();


    



      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({ 'memberId': memberID,'testimony': '$testimony', 'dateRequested': '$datesubmittedStr',  'status': 'Active' }));
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
  static TestimoniesClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final testimoniesClass = testimoniesClassFromJson(responseBody);
   return testimoniesClass;
  }
}