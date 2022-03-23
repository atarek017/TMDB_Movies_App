import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_movies/logic/controllers/main_screen_controller.dart';
import 'package:tmdb_movies/utils/theam.dart';

class MainScreen extends StatelessWidget {
   MainScreen({Key? key}) : super(key: key);

  final controller =Get.find<MainScreenController>();
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("The Movie Database"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          items:const  [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.local_movies,
                color: mainColor,
              ),
              icon: Icon(
                Icons.local_movies,
                color: Colors.black,
              ),
              label: "",
            ),

            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.tv,
                color: mainColor,
              ),
              icon: Icon(
                Icons.tv,
                color: Colors.black,
              ),
              label: "",
            ),

          ],
          onTap: (index){
            controller.currentIndex.value=index;
          },
        ),
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: controller.tabs,
        ),
      );
    });
  }
}
