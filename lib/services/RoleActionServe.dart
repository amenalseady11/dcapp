import 'package:dcapp/classes/MemberRoleClass.dart';
import 'package:dcapp/classes/RoleActionClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:dcapp/classes/zoneClass.dart';

class RoleActionService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/rolemanagements/getroleactions';
  static Future  <RoleActionClass> getRoleActions() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
       print(response.body);

        RoleActionClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> postAction(String action, int branchId, int memberId) async{

    try{
      const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/rolemanagements';
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'action': '$action', 'branchId': branchId,  'memberId': memberId}));
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

 static Future<MemberRoleClass> getRolesMember(int branchId) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/rolemanagements/getrolesmembersbybranch?branchID='+ branchId.toString();

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

       MemberRoleClass list = parse2(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

static Future<int> deleteMemberrole(int id) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/rolemanagements/deleteaction?ID='+ id.toString();

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

     return 200;
      }else {
       return 404;
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }




















  
 static Future<MemberRoleClass> getRolesMemberbyMemberId(int memberId) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/rolemanagements/getrolesbymemberid?memberID='+ memberId.toString();

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

       MemberRoleClass list = parse2(response.body);
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
  static RoleActionClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final roleClass = roleActionClassFromJson(responseBody);
    return roleClass;
  }

static MemberRoleClass parse2(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final memberroleClass = memberRoleClassFromJson(responseBody);
    return memberroleClass;
  }

}