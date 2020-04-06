
import 'package:dcapp/classes/DiscipleshipStatusClass.dart';
import 'package:dcapp/classes/MvpClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';



class DiscipleshipStatuservice{

  
  static Future<DiscipleshipStatusClass>  getDiscipleshipStatus(int branchID) async{
     String url =   'http://apekflux-001-site1.btempurl.com/v2/api/discipleships/GetDiscipleshipStatus?branchId=' + branchID.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        DiscipleshipStatusClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

   

static DiscipleshipStatusClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final discipleshipStatusClass = discipleshipStatusClassFromJson(responseBody);
    return discipleshipStatusClass;
  }
}