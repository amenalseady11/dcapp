import 'package:dcapp/classes/ZoneHeadClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class ZoneHeadService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/zoneheads';
  static Future <ZoneHeadClass> getZoneHead() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        ZoneHeadClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

   
  static Future <String> checkifzone(int memberID) async{
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/zoneheads/checkifzonehead?memberid='+ memberID.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        String list = response.body;
        return list;
      }else {
       // throw Exception("Error");
      }
    }
    catch(e){
     // throw Exception(e.toString());
    }
  }


    static Future<int> saveZoneHead(int zoneId, int memberId, DateTime datePosted, String status) async{

    try{

       String datepostedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(datePosted);
      datepostedStr = formateddateposted.toString();





      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'zoneId': zoneId, 'memberId': memberId,'datePosted': '$datepostedStr',  'status': 'Active'}));
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
  static ZoneHeadClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final zoneHeadClass = zoneHeadClassFromJson(responseBody);
    return zoneHeadClass;
  }
}