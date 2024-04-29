import 'package:flutter/material.dart';
import 'package:the_movie_db/Providers/data_provider.dart';
import 'package:the_movie_db/Providers/http_provider.dart';

import 'package:the_movie_db/Models/Movies/index.dart';

class DiscoverMovieModel extends ChangeNotifier {
  String title = "Discover Movie";
  late Result<Movies> movies;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

//  late Movies movies;

  DiscoverMovieModel() {
    fetchMovie();
  }

  fetchMovie() async {
    showLoader(true);
    movies = await DataProvider().getDiscoverMovie();
    notifyListeners();
    showLoader(false);
  }

  showLoader(bool state) {
    _isLoading = state;
    notifyListeners();
  }
}
