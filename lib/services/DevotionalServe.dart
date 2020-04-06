import 'package:dcapp/classes/DevotionalsClass.dart';
import 'package:dcapp/classes/DevotionalCommentClass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class DevotionalService {
  static Future<DevotionalClass> getDevotional() async {
    String url = 'http://apekflux-001-site1.btempurl.com/v2/api/devotionals';
    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        DevotionalClass list = parse(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<int> postDevotional(String title, String devotionaltext,
      DateTime datePublished, String status, int likeCount, String rawtext) async {
    String url = 'http://apekflux-001-site1.btempurl.com/v2/api/devotionals';
    try {
      String datepublishedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdateposted.format(datePublished);
      datepublishedStr = formateddateposted.toString();

      final response = await http.post(url,
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'title': '$title',
            'devotionaltext': '$devotionaltext',
            'datepublished': '$datepublishedStr',
            'status': 'Active',
            'likeCount': 0,
            'rawtext': '$rawtext'
          }));
      if (response.statusCode == 200) {
        //  print(response.body);

        int resp = getResponse(response.body);
        return resp;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

     static Future<int> updateDevotional(String title, String devotionaltext,
       String rawtext, int id) async {
    String url = 'http://apekflux-001-site1.btempurl.com/v2/api/devotionals/updateDevotional';
    try {
    

      final response = await http.post(url,
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'title': '$title',
            'devotionaltext': '$devotionaltext',
            'id': id,
            'rawtext': '$rawtext'
          }));
          
      if (response.statusCode == 200) {
        //  print(response.body);

        int resp = getResponse(response.body);
        return resp;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<DevotionalClass> updateDevotionalLikeCount(int devID) async {
    String url =
        'http://apekflux-001-site1.btempurl.com/v2/api/devotionals/UpdateLikeCount?devID=' +
            devID.toString();

    try {
      final response =
          await http.post(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        DevotionalClass list = getResponse(response.body) as DevotionalClass;
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<DevotionalCommentClass> getDevotionalComment(int devID) async {
    String url =
        'http://apekflux-001-site1.btempurl.com/v2/api/devotionals/GetDevotionalComment?devID=' +
            devID.toString();

    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        DevotionalCommentClass list = parseComment(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

   static Future<int> getDevotionalLikeCount(int devID) async {
    String url =
        'http://apekflux-001-site1.btempurl.com/v2/api/devotionals/GetDevotionalLikeCount?devID=' +
            devID.toString();

    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        int list = int.parse(response.body) ;
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  static Future<int> postDevotionalComment(
      DateTime dateCommented,
      String comment,
      int memberId,
      int devotionalId,
      int likeCount,
      String status) async {
    String url =
        'http://apekflux-001-site1.btempurl.com/v2/api/devotionals/PostDevotionalComments';
    try {
      String dateCommentedStr;
      var formatdateposted = new DateFormat('yyyy-MM-dd, hh:mm');
      String formateddateposted = formatdateposted.format(dateCommented);
      dateCommentedStr = formateddateposted.toString();

      final response = await http.post(url,
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'dateCommented': '$dateCommentedStr',
            'comment': '$comment',
            'memberId': memberId,
            'devotionalId': devotionalId,
            'likeCount': 0,
            'status': 'Active'
          }));
      if (response.statusCode == 200) {
        //  print(response.body);

        int devotionalClass = getResponse(response.body);
        return devotionalClass;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<DevotionalClass> devotionalCommentLikeCount(
      int commentID) async {
    String url =
        'http://apekflux-001-site1.btempurl.com/v2/api/devotionals/UpdateCommentLikeCount?commentID=' +
            commentID.toString();

    try {
      final response =
          await http.post(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        DevotionalClass list = getResponse(response.body) as DevotionalClass;
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static int getResponse(String responseBody) {
    int data;
    data = json.decode(responseBody)["id"];
    return data;
  }

  static DevotionalClass parse(String responseBody) {
    // Map data;
    // data = json.decode(responseBody);

    // final parsed = data["zones"].cast<Map<String,dynamic>>();
    final devotionalClass = devotionalClassFromJson(responseBody);
    return devotionalClass;
  }
    static DevotionalCommentClass parseComment(String responseBody) {
   
    final devotionalcommentClass = devotionalCommentClassFromJson(responseBody);
    return devotionalcommentClass;
  }
}
