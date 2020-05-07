import 'package:dcapp/classes/DepartmentHeadClass.dart';
import 'package:dcapp/classes/EventsClass.dart';
import 'package:dcapp/classes/FollowersClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dcapp/globals.dart' as global;


class GetMyFollowerService{

 
  static Future <FollowersClass> getFollower(int memberId) async{
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/myfollowers?memberid='+20.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        FollowersClass list = parse(response.body);
        return list;
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
  static FollowersClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final eventsClass =followersClassFromJson(responseBody);
    return eventsClass;
  }
}