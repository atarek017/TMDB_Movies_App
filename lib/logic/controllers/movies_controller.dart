import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_movies/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_movies/models/Movies.dart';
import 'package:tmdb_movies/models/auth_erorr.dart';
import 'package:tmdb_movies/services/movies_services.dart';

class MoviesController extends GetxController {
  var moviesList = <Movie>[].obs;
  var moviesWatchList = <Movie>[].obs;

  var isLoading = true.obs;

  var isLogged=true;

  @override
  void onInit() {
    isAuthLogged();

    getMoviesNowPlaying();

    fetchWatchlistMovies();
    super.onInit();
  }

  void getMoviesNowPlaying() async {
    var movies = await MoviesServices.fetchNowPlayingMovies();
    moviesList.addAll(movies);

    try {
      isLoading(true);

      if (movies.isEmpty) {}
    } finally {
      isLoading(false);
    }
  }

  void fetchWatchlistMovies() async {
    var movies = await MoviesServices.fetchWatchlistMovies();
    moviesWatchList = <Movie>[].obs;
    moviesWatchList.addAll(movies);

    try {
      isLoading(true);

      if (movies.isEmpty) {}
    } finally {
      isLoading(false);
    }
  }

  void addToWatchedList(
    String name,
    int id,
  ) async {
    await MoviesServices.addToWatchedList(name, id);
    fetchWatchlistMovies();
  }

  bool isWatchedMovie(Movie movie) {
    if (moviesWatchList == null || moviesWatchList.isEmpty) return false;
    return moviesWatchList.contains(movie);
  }

  Future<void> isAuthLogged() async {
    final prefs = await SharedPreferences.getInstance();
    isLogged=  prefs.getBool('isLogged') ?? false;

  }
}
