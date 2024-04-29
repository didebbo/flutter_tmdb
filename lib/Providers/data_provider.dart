import 'dart:convert';
import 'package:the_movie_db/Providers/http_provider.dart';

import 'package:the_movie_db/Models/index.dart';

class DataProvider {
  final httpProvider = HttpProvider();

  Future<Result<Movies>> getDiscoverMovie() async {
    try {
      final result = await httpProvider.callService(path: 'discover/movie');
      if (result.hasError) {
        return Result(
            error: result.error ?? "getDiscoverMovie has an undefined error");
      } else if (result.data?.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(result.data?.body ?? "");
        final movies = Movies.fromJson(json);
        return Result(data: movies);
      } else {
        final response = result.data;
        return Result(
            error: "${response?.statusCode} ${response?.reasonPhrase}");
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
