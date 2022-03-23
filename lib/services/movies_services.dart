import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_movies/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_movies/models/Movies.dart';

class MoviesServices {
// movie fetching

  static Future<List<Movie>> fetchNowPlayingMovies() async {
    final int _playingPage = 1;
    List<Movie> _playingMovies = [];

    print('Starting Now Playing movies request');

    final String url = Constants.baseUrl +
        Constants.nowPlaying +
        Constants.key +
        '&page=$_playingPage';

    http.Response response = await http.get(Uri.parse(url));

    print('Completed Now Playing movies request');
    print('Now Playing movies data : ${response.body}');

    var res = json.decode(response.body);

    res['results'].forEach((v) {
      _playingMovies.add(Movie.fromJson(v));
    });

    if (_playingMovies.isEmpty) {
      return throw Exception("Failed to load product");
    }
    return _playingMovies;
  }


  static Future<List<Movie>> fetchWatchlistMovies() async {
    List<Movie> _playingMovies = [];

    print('Starting Now Playing movies request');
    final prefs = await SharedPreferences.getInstance();
     String sessionId = prefs.getString('sessionId') ?? "";
      int? accountId = prefs.getInt('accountID');


    print('accountId $accountId');
    print('sessionId $sessionId');


    String url = Constants.baseUrl + "/account/$accountId/watchlist/movies?"+Constants.key+"&session_id=$sessionId";

    http.Response response = await http.get(Uri.parse(url));

    print('Completed Now Playing movies request');
    print('Now Playing movies data : ${response.body}');

    var res = json.decode(response.body);

    res['results'].forEach((v) {
      _playingMovies.add(Movie.fromJson(v));
    });

    if (_playingMovies.isEmpty) {
      return throw Exception("Failed to load product");
    }
    return _playingMovies;
  }




  static Future<void> addToWatchedList(
    String name,
    int id,
  ) async {

    print('Starting Now Playing movies request');

    final prefs = await SharedPreferences.getInstance();
    String sessionId = prefs.getString('sessionId') ?? "";
    int? accountId = prefs.getInt('accountID');


    print('accountId $accountId');
    print('sessionId $sessionId');


    Map<dynamic, dynamic> body = {
      'media_type': name,
      'media_id': id,
      'watchlist': true,
    };

    String url = Constants.baseUrl +
        "account/$accountId/watchlist?" +
        Constants.key +
        "&session_id=$sessionId";

    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode(body),
         headers: Constants.requestHeader);

    print('Completed Now Playing movies request');
    print('Now Playing movies data : ${response.body}');



  }
}
