import 'package:dcapp/classes/AttendaceClass.dart';
import 'package:dcapp/classes/AttendanceClass2.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;

class AttendanceService{

  
  static Future <AttendanceClass2> getAttendance(int branchId, DateTime date) async{

  String datepostedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(date);
      datepostedStr = formateddateposted.toString();

    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/attendances/GetAttendanceByBranch?date=' +datepostedStr;
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        AttendanceClass2 list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<String> saveAttendance(int memberID, int branchID, int zoneID,  DateTime date, bool selected) async{
       String url =   'http://apekflux-001-site1.btempurl.com/v2/api/attendances';
    try{

       String datepostedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(date);
      datepostedStr = formateddateposted.toString();


      var enteredBy = global.profile.member.memberId;



      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'branchId': branchID, 'memberId': memberID,'dateEntered': '$datepostedStr', 'zoneId': zoneID,  'enteredBy': enteredBy, 'selected': selected}));
      if(response.statusCode==200){
      //  print(response.body);

        String resp = getResponse(response.body);
        return resp;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static String getResponse(String responseBody){
    String data;
    data = json.decode(responseBody)["status"];
    return data;
  }
  static AttendanceClass2 parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final attendance2Class = attendanceClass2FromJson(responseBody);
   return attendance2Class;
  }
}