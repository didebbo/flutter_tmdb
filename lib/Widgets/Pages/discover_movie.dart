import 'package:flutter/material.dart';
import 'package:the_movie_db/Providers/http_provider.dart';

import '../../Models/Movies/movies.dart';
import '../../Models/Movies/movie.dart';

class DiscoverMovieModel {
  String title = "Discover Movie";
  late Future<Movies> movies;

  DiscoverMovieModel() {
    fetchMovie();
  }

  fetchMovie() async {
    movies = DataProvider().getDiscoverMovie();
  }
}

class DiscoverMovie extends StatefulWidget {
  DiscoverMovie({super.key});

  final DiscoverMovieModel viewModel = DiscoverMovieModel();

  @override
  State<StatefulWidget> createState() => _DiscoverMovie();
}

class _DiscoverMovie extends State<DiscoverMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Movie'),
      ),
      body: futureBody(),
    );
  }

  Widget futureBody() {
    return FutureBuilder(
      future: widget.viewModel.movies,
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData) {
            return listView(snapShot.data?.results ?? []);
          }
        }
        return loader();
      },
    );
  }

  Widget loader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget listView(List<Movie> movies) {
    return ListView(
      children: items(movies),
    );
  }

  List<Widget> items(List<Movie> movies) {
    return movies
        .map((e) => ListTile(
              title: Text(e.title),
            ))
        .toList();
  }
}
