import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_movies/logic/controllers/movies_controller.dart';
import 'package:tmdb_movies/routes/Routes.dart';
import 'package:tmdb_movies/utils/theam.dart';
import 'package:tmdb_movies/view/widgets/text_utils.dart';

class MovieWatchListScreen extends StatelessWidget {
  MovieWatchListScreen({Key? key}) : super(key: key);
  final controller = Get.find<MoviesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLogged==false ) {
        return Container(
          child: Center(
            child: TextButton(
              onPressed: () {
                Get.offNamed(Routes.authScreen);
              },
              child: TextUtils(
                  text: ' You must "Log IN" ',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  underLine: TextDecoration.underline),
            ),
          ),
        );
      }

      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: mainColor),
        );
      } else {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView.separated(
              itemBuilder: (context, index) {
                return buildWatchListItems(index);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey,
                  thickness: 1,
                );
              },
              itemCount: controller.moviesWatchList.length),
        );
      }
    });
  }

  Widget buildWatchListItems(index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            SizedBox(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${controller.moviesWatchList[index].posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 10,
              child: TextUtils(
                  text: controller.moviesWatchList[index].title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  underLine: TextDecoration.none),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark,
                  size: 30,
                  color: mainColor,
                ))
          ],
        ),
      ),
    );
  }
}
