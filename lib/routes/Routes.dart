import 'package:get/get.dart';
import 'package:tmdb_movies/logic/binding/auth_binding.dart';
import 'package:tmdb_movies/logic/binding/main_binding.dart';
import 'package:tmdb_movies/logic/binding/movies_binding.dart';
import 'package:tmdb_movies/view/screens/auth_screen.dart';
import 'package:tmdb_movies/view/screens/main_screen.dart';
import 'package:tmdb_movies/view/screens/playing_now_movies_screen.dart';

class AppRoutes {
  static const auth = Routes.authScreen;

  static final routes = [
    GetPage(
      name: Routes.authScreen,
      page: () => AuthScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      bindings: [
        AuthBinding(),
        MainBinding(),
        MovieBinding()
      ],
    ),
    GetPage(
      name: Routes.nowPlayingMoviesScreen,
      page: () => NowPlayingMoviesScreen(),
      binding: AuthBinding(),
    ),
  ];
}

class Routes {
  static const String authScreen = '/auth';
  static const String mainScreen = '/mainScreen';
  static const String nowPlayingMoviesScreen = '/nowPlayingMoviesScreen';
}
