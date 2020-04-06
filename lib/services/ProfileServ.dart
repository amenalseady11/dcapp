import 'package:dcapp/classes/ProfileClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class ProfileService{

 
  static Future<ProfileClass> authenticate(String username, String password) async{
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/members/Authenticate?Username='+username+'&Password='+password;

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
       //print(response.body);

        ProfileClass list = parse(response.body);
        return list;
      }else {
         ProfileClass list =ProfileClass();
         list.status="Failed";
         list.trainingindex="";
         list.trainingTables=null;
         list.actions = null;
         list.allTraining=null;
         list.deptDirectory = null;
         list.deptTable = null;
         list.member=null;
         list.membersDept=null;
         list.membersTrainings = null;
         return list;

       
      }
    }
    catch(e){
      ProfileClass list =ProfileClass();
         list.status="Failed";
         list.trainingindex="";
         list.trainingTables=null;
         list.actions = null;
         list.allTraining=null;
         list.deptDirectory = null;
         list.deptTable = null;
         list.member=null;
         list.membersDept=null;
         list.membersTrainings = null;
         return list;
    }
  }

    
  static int getResponse(String responseBody){
    int data;
    data = json.decode(responseBody)["id"];
    return data;
  }
  static ProfileClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
   final profileClass = profileClassFromJson(responseBody);
    return profileClass;
  }
}