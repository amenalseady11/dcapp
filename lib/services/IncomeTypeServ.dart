import 'package:dcapp/classes/IncomeTypeClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class IncomeTypeService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/incometypes';
  static Future<IncomeTypeClass>  getIncomeType() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        IncomeTypeClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveIncomeType(String incomeName, ) async{

    try{






      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'incomeName': incomeName, }));
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
static IncomeTypeClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final incomeTypeClass = incomeTypeClassFromJson(responseBody);
    return incomeTypeClass;
  }
}