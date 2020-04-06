
import 'package:dcapp/classes/MvpClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';



class MVPService{

  
  static Future<MvpClass>  getMvp(int branchID) async{
     String url =   'http://apekflux-001-site1.btempurl.com/v2/api/members/getmvp?branchId=' + branchID.toString();
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        MvpClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

   

static MvpClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final mvpClass = mvpClassFromJson(responseBody);
    return mvpClass;
  }
}