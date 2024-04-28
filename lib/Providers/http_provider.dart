import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:the_movie_db/Models/Movies/movies.dart';

class HttpProvider {
  final Map<String, String> _header = {
    'accept': 'application/json',
    'Authorization': 'Bearer ${dotenv.env['TMDB_ACCESS_TOKEN']}',
  };
  final String _host = 'https://api.themoviedb.org/3/';

  @override
  String toString(
          {String path = '', Map<String, dynamic> queryParams = const {}}) =>
      'header:$_header\nhost:$_host\npath:$path\nqueryParams:$queryParams';

  String fullPath(String path, Map<String, String> queryParams) =>
      '$_host$path${queryString(queryParams)}';

  String queryString(Map<String, String> queryParams) {
    String stringQueryParams = '';
    List<String> listQueryParams =
        queryParams.entries.map((e) => '\'${e.key}\'=\'${e.value}\'').toList();
    if (listQueryParams.isNotEmpty) {
      stringQueryParams = '?';
      stringQueryParams += listQueryParams.join('&');
    }
    return stringQueryParams;
  }

  Future<http.Response> callService(
          {String path = '',
          Map<String, String> queryParams = const {}}) async =>
      http.get(Uri.parse(fullPath(path, queryParams)), headers: _header);
}

class DataProvider {
  final logger = Logger();
  final httpProvider = HttpProvider();

  Future<Movies?> getDiscoverMovie() async {
    final response = await httpProvider.callService(path: 'discover/movie');
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final movies = Movies.fromJson(json);
      return movies;
    }
    return null;
  }
}
