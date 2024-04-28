import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  MovieList({super.key});

  final List<String> list = ["Uno", "Due", "Tre"];

  @override
  State<StatefulWidget> createState() => _MovieList();
}

class _MovieList extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MovieList"),
      ),
      body: ListView(
        children: listItems(),
      ),
    );
  }

  List<Widget> listItems() {
    return widget.list
        .map((e) => ListTile(
              title: Text(e),
            ))
        .toList();
  }
}
