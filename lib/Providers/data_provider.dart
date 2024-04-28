import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:the_movie_db/Providers/http_provider.dart';

import 'package:the_movie_db/Models/index.dart';

class DataProvider {
  final logger = Logger();
  final httpProvider = HttpProvider();

  Future<Result<Movies>> getDiscoverMovie() async {
    try {
      final result = await httpProvider.callService(path: 'discover/movie');
      if (result.hasError) {
        return Result(
            error: result.error ?? "getDiscoverMovie has an undefined error");
      } else if (result.result?.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(result.result?.body ?? "");
        final movies = Movies.fromJson(json);
        return Result(result: movies);
      } else {
        final response = result.result;
        return Result(
            error: "${response?.statusCode} ${response?.reasonPhrase}");
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
