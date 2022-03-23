import 'package:get/get.dart';
import 'package:tmdb_movies/logic/controllers/account_controller.dart';
import 'package:tmdb_movies/logic/controllers/auth_controller.dart';
import 'package:tmdb_movies/logic/controllers/movies_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(AccountController());
    Get.put(MoviesController());
  }
}
