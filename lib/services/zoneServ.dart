import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:dcapp/classes/zoneClass.dart';

class ZoneService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/zones';
  static Future<List<ZoneClass>> getZones() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
       print(response.body);

        List<ZoneClass> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveZones(String zoneName, String adress, int branchID) async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'zoneName': '$zoneName', 'adress': '$adress',  'branchID': branchID}));
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
  static List<ZoneClass> parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final zoneClass = zoneClassFromJson(responseBody);
    return zoneClass;
  }
}