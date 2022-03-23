class Movie {
  final int id;
  final String posterPath;
  final String title;

  Movie({
    required this.id,
    required this.posterPath,
    required this.title,
  });

  Movie.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        posterPath = parsedJson['poster_path'],
        title = parsedJson['title'];
}
