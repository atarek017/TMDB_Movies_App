
import 'package:get/get.dart';
import 'package:tmdb_movies/logic/controllers/main_screen_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MainScreenController());
  }

}