import 'package:get/get.dart';
import 'package:tmdb_movies/logic/controllers/movies_controller.dart';

class MovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MoviesController());
  }

}