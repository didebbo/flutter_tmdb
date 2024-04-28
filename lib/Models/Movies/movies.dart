import 'movie.dart';

class Movies {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  Movies(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults});

  factory Movies.fromJson(Map<String, dynamic> json) {
    List<dynamic> resultsJson = json['results'];
    List<Movie> results =
        resultsJson.map((result) => Movie.fromJson(result)).toList();

    return Movies(
        page: json["page"],
        results: results,
        totalPages: json["total_pages"],
        totalResults: json["total_results"]);
  }
}
