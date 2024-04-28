import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class HttpProvider {
  Map<String, String> header;
  String host;
  String? path;
  Map<String, String>? query;

  HttpProvider({
    Map<String, String>? header,
    String? host,
    this.path,
    this.query,
  })  : header = header ??
            {
              'accept': 'application/json',
              'Authorization': 'Bearer ${dotenv.env['TMDB_API_KEY']}',
            },
        host = host ?? 'https://api.themoviedb.org/3/';

  @override
  String toString() =>
      'header: $header\nhost: $host\npath: $path\nquery: $query';

  String fullPath() => '$host${path ?? ''}${queryParams()}';

  String queryParams() {
    String stringQueryParams = '';
    List<String> listQueryParams =
        query?.entries.map((e) => '\'${e.key}\'=\'${e.value}\'').toList() ?? [];
    if (listQueryParams.isNotEmpty) {
      stringQueryParams = '?';
      stringQueryParams += listQueryParams.join('&');
    }
    return stringQueryParams;
  }
}

class ResponseProvider {
  final httpProvider = HttpProvider();

  logHttpProvider() {
    Logger().i(httpProvider.fullPath());
  }
}
