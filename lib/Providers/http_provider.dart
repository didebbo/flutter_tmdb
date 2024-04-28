import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Result<T> {
  Result({this.result, this.error});

  final T? result;
  final String? error;

  late bool hasError = result == null;
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

  Future<Result<http.Response>> callService(
      {String? host,
      String path = '',
      Map<String, String> queryParams = const {},
      int delay = 2,
      int timeOut = 30}) async {
    try {
      final result = await Future.delayed(
          Duration(seconds: delay),
          () => http.get(Uri.parse(_fullPath(host, path, queryParams)),
              headers: _header));
      return Result(result: result);
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
