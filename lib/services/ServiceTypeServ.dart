
import 'package:dcapp/classes/ServicTypeClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class ServiceTypeService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/servicetypes';
  static Future<ServiceTypeClass>  getServiceType() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        ServiceTypeClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveServiceType(String serviceName, ) async{

    try{






      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'serviceName': serviceName, }));
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
static ServiceTypeClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final serviceTypeClass = serviceTypeClassFromJson(responseBody);
    return serviceTypeClass;
  }
}