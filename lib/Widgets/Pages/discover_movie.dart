import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:the_movie_db/Models/Movies/index.dart';
import 'package:the_movie_db/Providers/data_provider.dart';
import 'package:the_movie_db/Providers/http_provider.dart';

class DiscoverMovieModel {
  final logger = Logger();

  String title = "Discover Movie";
  late Future<Result<Movies>> movies;

//  late Movies movies;

  DiscoverMovieModel() {
    fetchMovie();
  }

  fetchMovie() async {
    movies = Future(() async {
      try {
        final data = await DataProvider().getDiscoverMovie();
        return Result(result: data);
      } catch (e) {
        return Result(error: ErrorDescription(e.toString()));
      }
    });
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
            final result = snapShot.data;
            if (result?.hasError ?? true) {
              return errorMessage(
                  result?.error?.toDescription() ?? "An error occurred");
            }
            return listView(snapShot.data?.result?.results ?? []);
          }
          if (snapShot.hasError) {
            return errorMessage(snapShot.error.toString());
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

  Widget errorMessage(String text) {
    return Center(
      child: Text(text),
    );
  }

  Widget listView(List<Movie> movies) {
    return ListView(
      children: items(movies),
    );
  }

  List<Widget> items(List<Movie> movies) {
    return movies
        .map((m) => ListTile(
              title: Text(m.title),
            ))
        .toList();
  }
}
