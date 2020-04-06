import 'package:dcapp/classes/DepartmentHeadClass.dart';
import 'package:dcapp/classes/DepthHeadExistClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class DepartmentHeadService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/departmentheads';
  static Future <DepartmentHeadClass> getDeptHead() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        DepartmentHeadClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

   
  static Future <DepthHeadExistClass> checkifdepthead(int memberID) async{
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/departments/checkifdepartmenthead?memberid='+ memberID.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        DepthHeadExistClass list = parse2(response.body);
        return list;
      }else {
       // throw Exception("Error");
      }
    }
    catch(e){
     // throw Exception(e.toString());
    }
  }

    static Future<int> saveDeptHead( int memberId, int branchID, int departmentId, DateTime datePosted,  String status) async{

    try{

       String datepostedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(datePosted);
      datepostedStr = formateddateposted.toString();





      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({ 'memberId': memberId, 'branchId' :branchID, 'departmentId' :departmentId,  'datePosted': '$datepostedStr',  'status': 'Active'}));
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
  static DepartmentHeadClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final departmentHeadClass = departmentHeadClassFromJson(responseBody);
    return departmentHeadClass;
  }
 static DepthHeadExistClass parse2(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
   final depthHeadExistClass = depthHeadExistClassFromJson(responseBody);
    return depthHeadExistClass;
  }


}