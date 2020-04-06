import 'package:dcapp/classes/DepartmentHeadClass.dart';
import 'package:dcapp/classes/EventsClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dcapp/globals.dart' as global;


class EventService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/events';
  static Future <EventsClass> getEvents() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
      // print(response.body);

        EventsClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> postEvent( DateTime eventDate, String eventTime, String title, String description,  String venue, String bannerurl, String status, var filePath) async{

    try{

       String eventdateStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(eventDate);
      eventdateStr = formateddateposted.toString();

      var formData = FormData.fromMap({
        "eventDate": '$eventdateStr', 'eventTime': '$eventTime' , 'title': '$title',  'description': '$description',  'location': '$venue','bannerurl': '$bannerurl', 'status': 'ACTIVE',
        "files": MultipartFile.fromFileSync(filePath)

      });

      Response response = 
      await Dio().post(url,data: formData);
      var resp = getResponse(response.data);
      return resp;

    }
    catch(e){
    return 1;
    }
  }


  static int getResponse(String responseBody){
    int data;
    data = json.decode(responseBody)["id"];
    return data;
  }
  static EventsClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
  final eventsClass = eventsClassFromJson(responseBody);
    return eventsClass;
  }
}