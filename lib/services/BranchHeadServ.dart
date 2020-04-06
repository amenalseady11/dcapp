import 'package:dcapp/classes/BranchHeadClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class BranchHeadService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/branchheads';
  static Future <BranchHeadClass> getBranchHead() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        BranchHeadClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    
  static Future <String> checkifBranchHead(int memberId) async{
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/branchheads/checkifbranchhead?memberId='+memberId.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        String list = response.body;
        return list;
      }else {
       // throw Exception("Error");
      }
    }
    catch(e){
     // throw Exception(e.toString());
    }
  }







    static Future<int> saveBranchHead(int branchID, int memberID, DateTime datePosted, String status) async{

    try{

       String datepostedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(datePosted);
      datepostedStr = formateddateposted.toString();





      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'branchID': branchID, 'memberID': memberID,'datePosted': '$datepostedStr',  'status': 'Active'}));
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
  static BranchHeadClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final branchHeadClass = branchHeadClassFromJson(responseBody);
    return branchHeadClass;
  }
}