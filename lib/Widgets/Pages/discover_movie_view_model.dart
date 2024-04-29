import 'package:the_movie_db/Providers/data_provider.dart';
import 'package:the_movie_db/Providers/http_provider.dart';

import 'package:the_movie_db/Models/Movies/index.dart';

class DiscoverMovieModel {
  String title = "Discover Movie";
  late Future<Result<Movies>> movies;

//  late Movies movies;

  DiscoverMovieModel() {
    fetchMovie();
  }

  fetchMovie() async {
    movies = DataProvider().getDiscoverMovie();
  }
}
