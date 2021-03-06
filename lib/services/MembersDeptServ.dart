import 'package:dcapp/classes/AttendaceClass.dart';
import 'package:dcapp/classes/AttendanceClass2.dart';
import 'package:dcapp/classes/NewsClass.dart';
import 'package:dcapp/classes/PrayerRequestClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;

class MembersDepartmentService{

  

    static Future<int> postMembDept(int branchId, int deptId, int memberId ) async{
       String url =   'http://apekflux-001-site1.btempurl.com/v2/api/membersdepartments';
    try{

    



      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'branchId': branchId, 'departmentId': deptId,  'memberId': memberId }));
      if(response.statusCode==200){
      //  print(response.body);

        int resp = int.parse(response.body);
        return resp;
      }else {
        return 0;
      }
    }
    catch(e){
     return  0;
    }
  }

  static int getResponse(String responseBody){
    int data;
    data = json.decode(responseBody)["id"];
    return data;
  }
 
}