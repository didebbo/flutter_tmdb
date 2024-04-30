import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_movie_db/Models/Movies/index.dart';
import 'package:the_movie_db/Widgets/Pages/discover_movie_view_model.dart';

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
      body: changeNotifierViewModel(),
    );
  }

  Widget changeNotifierViewModel() {
    return ChangeNotifierProvider(
      create: (_) => DiscoverMovieModel(),
      child: Consumer<DiscoverMovieModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return loader();
          } else if (viewModel.movies.hasError) {
            return errorMessage(viewModel.movies.error ?? "Undefined Error");
          } else {
            return listView(viewModel.movies.data?.results ?? []);
          }
        },
      ),
    );
  }

  Widget loader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget errorMessage(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget listView(List<Movie> movies) {
    final screenWidth = MediaQuery.of(context).size.width / 1.1;

    return Align(
        alignment: Alignment.center,
        child: Container(
          width: screenWidth,
          color: Colors.amber,
          child: ListView(
            children: items(movies),
          ),
        ));
  }

  List<Widget> items(List<Movie> movies) {
    return movies.map((m) => itemCard(m)).toList();
  }

  Widget itemCard(Movie item) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double aspectRatio = 0.6;
        final screenWidth = constraints.maxWidth;
        final screenHeight = screenWidth * aspectRatio;

        return Column(children: [
          Container(
            color: Colors.grey,
            width: screenWidth,
            height: screenHeight,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(item.title,
                style: const TextStyle(backgroundColor: Colors.red)),
          ),
        ]);
      },
    );
  }
}
