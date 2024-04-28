import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_movie_db/Widgets/Pages/movie_list.dart';
import 'Providers/http_provider.dart';

void main() async {
  await dotenv.load();
  DataProvider().printDiscoverMovie();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieList(),
    );
  }
}
