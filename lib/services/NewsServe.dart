import 'package:dcapp/classes/AttendaceClass.dart';
import 'package:dcapp/classes/AttendanceClass2.dart';
import 'package:dcapp/classes/NewsClass.dart';
import 'package:dcapp/classes/PrayerRequestClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dcapp/globals.dart' as global;

class NewsService{

  
  static Future <NewsClass> getNews() async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/news'; 
    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        NewsClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }


    static Future<int> postNews(DateTime datePosted, String headline,   String  newsDescription, String status, int viewCount ) async{
       String url =   'http://apekflux-001-site1.btempurl.com/v2/api/news';
    try{

      String datepostedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(datePosted);
      datepostedStr = formateddateposted.toString();


    



      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'datePosted': '$datepostedStr', 'headline': '$headline',  'newsDescription': '$newsDescription', 'status': 'Active',  'viewCount': 0 }));
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

 static Future <NewsClass> updateNewsCount(int newsID) async{

 
    String url =   'http://apekflux-001-site1.btempurl.com/v2/api/news/UpdateViewCount?newsID='+ newsID.toString();

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        NewsClass list = getResponse(response.body) as NewsClass;
        return list;
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
  static NewsClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final newsClass = newsClassFromJson(responseBody);
   return newsClass;
  }
}