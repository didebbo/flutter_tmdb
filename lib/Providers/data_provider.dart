import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:the_movie_db/Providers/http_provider.dart';

import 'package:the_movie_db/Models/index.dart';

class DataProvider {
  final logger = Logger();
  final httpProvider = HttpProvider();

  Future<Movies> getDiscoverMovie() async {
    try {
      final response = await httpProvider.callService(
          host: 'https://google.com/', path: 'discover/movie');
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final movies = Movies.fromJson(json);
        return movies;
      } else {
        throw ErrorDescription(
            "${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
