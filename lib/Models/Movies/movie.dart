class Movie {
  int id;
  String title;
  String posterPath;
  String get posterFullPath => 'https://image.tmdb.org/t/p/w500/$posterPath';

  Movie({required this.id, required this.title, required this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'], title: json['title'], posterPath: json['poster_path']);
  }
}
