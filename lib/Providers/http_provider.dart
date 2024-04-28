import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Result<T> {
  Result({this.result, this.error});

  final T? result;
  final ErrorDescription? error;

  late bool hasError = error != null;
}

class HttpProvider {
  final Map<String, String> _header = {
    'accept': 'application/json',
    'Authorization': 'Bearer ${dotenv.env['TMDB_ACCESS_TOKEN']}',
  };

  final String _host = 'https://api.themoviedb.org/3/';

  String _fullPath(
          String? host, String path, Map<String, String> queryParams) =>
      '${host ?? _host}$path${queryString(queryParams)}';

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
      {String? host,
      String path = '',
      Map<String, String> queryParams = const {},
      int delay = 2,
      int timeOut = 30}) async {
    return Future.delayed(
        Duration(seconds: delay),
        () => http.get(Uri.parse(_fullPath(host, path, queryParams)),
            headers: _header));
  }
}
