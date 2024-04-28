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
    return Movies(
        page: json["page"],
        results: json["results"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"]);
  }
}
