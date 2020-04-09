import 'package:dcapp/classes/SmsTemplateClass.dart';
import 'package:dcapp/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class TokenService{

  
 
    static Future<int> postToken( int memberId, String token) async{
     String url =   'http://apekflux-001-site1.btempurl.com/v2/api/tokens';

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({ 'memberId': memberId,'token': '$token',  }));
      if(response.statusCode==200){
      //  print(response.body);

       
        return 1;
      }else {
       return 0;
      }
    }
    catch(e){
     return 0;
    }
  }

  static int getResponse(String responseBody){
    int data;
    data = json.decode(responseBody)["id"];
    return data;
  }
  static SmsTemplateClass parse(String responseBody){
  final smsTemplateClass = smsTemplateClassFromJson(responseBody);
    return smsTemplateClass;
  }
}