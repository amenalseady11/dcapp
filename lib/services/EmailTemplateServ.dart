import 'package:dcapp/classes/EmailTemplateClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class EmailTemplateService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/emailtemplates';
  static Future <EmailTemplateClass> getEmailTemplate() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        EmailTemplateClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveEmailTemplate( int branchID, int zoneId,  String emailTitle, String emailBody,  ) async{

    try{



      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'zoneId': zoneId, 'branchId': branchID,'emailTitle': '$emailTitle',  'emailBody': '$emailBody', 'memberId': 2}));
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
  static EmailTemplateClass parse(String responseBody){
  final emailTemplateClass = emailTemplateClassFromJson(responseBody);
    return emailTemplateClass;
  }
}