import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:dcapp/classes/BranchClass.dart';

class BranchService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/branches';
  static Future<List<BranchClass>> getBranches() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
       print(response.body);

        List<BranchClass> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveBranches(String branch, String state, String city, String country, int parentID) async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'branchName': '$branch', 'state': '$state', 'city': '$city', 'country': '$country', 'parentID': parentID,'status': 'Active'}));
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
  static List<BranchClass> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["branches"].cast<Map<String,dynamic>>();
    return parsed.map<BranchClass>((json)=> BranchClass.fromJson(json)).toList();
  }
}