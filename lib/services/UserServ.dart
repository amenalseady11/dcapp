import 'package:dcapp/classes/AttendaceClass.dart';
import 'package:dcapp/classes/AttendanceClass2.dart';
import 'package:dcapp/classes/PrayerRequestClass.dart';
import 'package:dcapp/classes/UsersClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;

class UserService{

  
  static Future <UserClass> getUser(int branchId) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/users/getusersbybranchid?branchid='+ branchId.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        UserClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
static Future <int> getCredentials(String email) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/members/getcredentials?email='+ email.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        int list = int.parse(response.body);
        return list;
      }else {
       return 0;
      }
    }
    catch(e){
     return 0;
    }
  }


  static Future <int> updateUserPosition(int id, String position) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/users/updateuserposition?id='+ id.toString()+'&position='+position;
    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

       // String list = getResponse(response.body);
        return response.statusCode;
      }else {
       // throw Exception("Error");
      }
    }
    catch(e){
     // throw Exception(e.toString());
    }
  }

  static String getResponse(String responseBody){
    String data;
    data = json.decode(responseBody);
    return data;
  }
  static UserClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final userClass = userClassFromJson(responseBody);
   return userClass;
  }
}