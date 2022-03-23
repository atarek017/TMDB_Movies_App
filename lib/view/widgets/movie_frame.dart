import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:tmdb_movies/logic/controllers/movies_controller.dart';
import 'package:tmdb_movies/utils/theam.dart';

class MovieFrame extends StatelessWidget {
  final controller = Get.find<MoviesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: mainColor),
        );
      } else {
        return Expanded(
            child: GridView.builder(
              itemCount: controller.moviesList.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: .8,
                mainAxisSpacing: 9.0,
                crossAxisSpacing: 6.0,
                maxCrossAxisExtent: 200,
              ),
              itemBuilder: (context, index) {
                return buildCard(index);
              },
            ));
      }
    });
  }

  Widget buildCard(index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ]),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: IconButton(
               icon: Icon(controller.isWatchedMovie(controller.moviesList[index])
               ? Icons.bookmark
               : Icons.bookmark_border),
                onPressed: () {
                  controller.addToWatchedList(
                      "movie",
                      controller.moviesList[index].id);

                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${controller.moviesList[index]
                    .posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              width: 170,
              height: 40,
              child: AutoSizeText(
                controller.moviesList[index].title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//      todo favourit icon
//      Positioned(
//        top: -5,
//        left: 135,
//        child: IconButton(
//            icon: Icon(_accountProvider.isFavoriteMovie(provider.getNowPlayingMovies()[index])
//                ? Icons.favorite
//                : Icons.favorite_border),
//            onPressed: () {
//              setState(() {
//                _accountProvider.changeFavoriteMedia(
//                    sessionId: _authentication.sessionId,
//                    mediaType: MediaType.Movie,
//                    movie: provider.getNowPlayingMovies()[index]);
//              });
//            }),
//      ),
//
//