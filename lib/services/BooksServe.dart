import 'package:dcapp/classes/BooksClass.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class BookService {
  static const String url =
      'http://apekflux-001-site1.btempurl.com/v2/api/books';
  static Future<BooksClass> getBooks() async {
    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        BooksClass list = parse(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<int> postBook(
      String title,
      String description,
      String author,
      DateTime datePosted,
      String category,
      String amount,
      String uRL,
      String status,
      String thumbnail,
      var bookFile,
      var coverFile) async {
    try {
      String datePostedStr;
      var formatdatePosted = new DateFormat('yyyy-MM-dd');
      String formateddateposted = formatdatePosted.format(datePosted);
      datePostedStr = formateddateposted.toString();

      var formData = FormData.fromMap({
        "eventDate": '$datePostedStr',
        'title': '$title',
        'description': '$description',
        'author': '$author',
        'category': '$category',
        'status': 'ACTIVE',
        'amount': '$amount',
        'uRL': 'test.url',
        'thumbnail': 'test.url',
        "book": MultipartFile.fromFileSync(bookFile),
        "cover": MultipartFile.fromFileSync(coverFile)
      });

      Response response = await Dio().post(url, data: formData);
      var resp = getResponse(response.data);
      return resp;
    } catch (e) {
      return 1;
    }
  }

  static Future<BooksClass> getThumbNail(int bookID) async {
    String url =
        'http://apekflux-001-site1.btempurl.com/v2/api/books/GetThumbnail?bookid=' +
            bookID.toString();

    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        BooksClass list = parsethumbNail(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<int> getBookById(int bookID) async {
    String url =
        ' http://apekflux-001-site1.btempurl.com/v2/api/books/GetBook?bookid=' +
            bookID.toString();

    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

        int list = int.parse(response.body);
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

  static BooksClass parse(String responseBody) {
    // Map data;
    // data = json.decode(responseBody);

    // final parsed = data["zones"].cast<Map<String,dynamic>>();
    final bookClass = booksClassFromJson(responseBody);
    return bookClass;
  }

  static BooksClass parsethumbNail(String responseBody) {
    final booksClass = booksClassFromJson(responseBody);
    return booksClass;
  }
}
