import 'package:dcapp/classes/DepartmentsClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class DepartmentService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/departments';
  static Future<DepartmentClass>  getDepartment() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        DepartmentClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveDepartment(String departmentName, ) async{

    try{






      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'departmentName': departmentName, }));
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
static DepartmentClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final departmentClass = departmentClassFromJson(responseBody);
    return departmentClass;
  }
}