// To parse this JSON data, do
//
//     final booksClass = booksClassFromJson(jsonString);

import 'dart:convert';

BooksClass booksClassFromJson(String str) => BooksClass.fromJson(json.decode(str));

String booksClassToJson(BooksClass data) => json.encode(data.toJson());

class BooksClass {
    List<Book> books;
    String status;
    dynamic id;

    BooksClass({
        this.books,
        this.status,
        this.id,
    });

    factory BooksClass.fromJson(Map<String, dynamic> json) => BooksClass(
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class Book {
    int bookId;
    String title;
    String description;
    String author;
    DateTime datePosted;
    String category;
    double amount;
    String url;
    String status;
    String thumbnail;

    Book({
        this.bookId,
        this.title,
        this.description,
        this.author,
        this.datePosted,
        this.category,
        this.amount,
        this.url,
        this.status,
        this.thumbnail,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        bookId: json["bookID"],
        title: json["title"],
        description: json["description"],
        author: json["author"],
        datePosted: DateTime.parse(json["datePosted"]),
        category: json["category"],
        amount: json["amount"],
        url: json["url"],
        status: json["status"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "bookID": bookId,
        "title": title,
        "description": description,
        "author": author,
        "datePosted": datePosted.toIso8601String(),
        "category": category,
        "amount": amount,
        "url": url,
        "status": status,
        "thumbnail": thumbnail,
    };

  
}
