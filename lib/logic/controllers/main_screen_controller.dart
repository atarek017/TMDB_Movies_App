

import 'package:get/get.dart';
import 'package:tmdb_movies/view/screens/movie_watch_list_screen.dart';
import 'package:tmdb_movies/view/screens/playing_now_movies_screen.dart';

class MainScreenController extends GetxController{
  RxInt currentIndex=0.obs;

  final tabs=[
    NowPlayingMoviesScreen(),
    MovieWatchListScreen(),
  ].obs;

  final title= [
    "Now Playing",
    "Watch List",
  ].obs;
}