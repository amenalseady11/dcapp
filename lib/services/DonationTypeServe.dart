
import 'package:dcapp/classes/DonationTypeClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class DonationTypeService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/donationtypes';
  static Future<DonationTypeClass>  getDonationType() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        DonationTypeClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveDonationType(String donationName, String note ) async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'donationName': donationName, 'note': note }));
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
static DonationTypeClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final donationTypeClass = donationTypeClassFromJson(responseBody);
    return donationTypeClass;
  }
}