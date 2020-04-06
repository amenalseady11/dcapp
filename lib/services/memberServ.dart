import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:dcapp/classes/memberClass.dart';
import 'package:intl/intl.dart';


class MemberService{

  static const String url =   'http://apekflux-001-site1.btempurl.com/v2/api/members';
  static Future<MemberClass> getMembers() async{

    try{
      final response = await http.get(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
       print(response.body);

        MemberClass list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

    static Future<int> saveMembers( String firstName, String middleName, String surName, String address, String city, String country, String state,String phoneNumber,String emailAddress, DateTime dob, String gender, String maritalStatus, DateTime anniversary, int invitedBy, String note,String status,
     bool guest, DateTime dateJoined, String pictureURL, int branchID, int zoneID) async{

    try{
      //format dob, anniversary, datejoined to be yyyy-dd-mm
      String dobstr;
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(dob);
      dobstr = formatted.toString();

      String datejoinedstr;
      var format = new DateFormat('yyyy-MM-dd');
      String datejoined = format.format(dateJoined);
      datejoinedstr = datejoined.toString();



      String anniversarystr;
      var formatanniversary = new DateFormat('yyyy-MM-dd');
      String formatedanniversary = formatanniversary.format(anniversary);
      anniversarystr = formatedanniversary.toString();


      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'firstName': '$firstName','middleName': '$middleName',  'surName': '$surName', 'address': '$address', 'city': '$city','country': '$country','state': '$state','phoneNumber': '$phoneNumber','emailAddress': '$emailAddress','dob': '$dobstr','gender': '$gender','maritalStatus': '$maritalStatus','anniversary': '$anniversarystr','invitedBy': invitedBy,'note': '$note','status': 'Active', 'guest': guest,'dateJoined': '$datejoinedstr','pictureURL': 'images/Male.jpg','branchID': branchID,'zoneID': zoneID}));
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
  static MemberClass parse(String responseBody){
   // Map data;
   // data = json.decode(responseBody);

   // final parsed = data["zones"].cast<Map<String,dynamic>>();
   final memberClass = memberClassFromJson(responseBody);
    return memberClass;
  }
}