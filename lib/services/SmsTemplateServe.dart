import 'package:dcapp/classes/SmsTemplateClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class SmsTemplateService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/smstemplates';
  static Future <SmsTemplateClass> getSmsTemplate() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        SmsTemplateClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveSmsTemplate( int branchID, int zoneId,  String smsTitle, String sms,  ) async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'zoneId': zoneId, 'branchId': branchID,'sMSTitle': '$smsTitle',  'sms': '$sms', 'memberId': 2}));
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
  static SmsTemplateClass parse(String responseBody){
  final smsTemplateClass = smsTemplateClassFromJson(responseBody);
    return smsTemplateClass;
  }
}