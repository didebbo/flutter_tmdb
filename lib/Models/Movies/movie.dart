import 'dart:convert';

class Movie {
  int id;
  String title;

  Movie({required this.id, required this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(id: json['id'], title: json['title']);
  }
}
