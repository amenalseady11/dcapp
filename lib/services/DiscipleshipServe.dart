import 'package:dcapp/classes/DiscipleshipClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class DiscipleshipService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/discipleships';
  static Future<DiscipleshipClass>  getDiscipleship() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        DiscipleshipClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveDiscipleship(String trainingName, ) async{

    try{






      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'trainingName': trainingName, }));
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
static DiscipleshipClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final discipleshipClass = discipleshipClassFromJson(responseBody);
    return discipleshipClass;
  }
}