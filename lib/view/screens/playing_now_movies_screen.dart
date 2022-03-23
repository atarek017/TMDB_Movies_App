import 'package:flutter/material.dart';
import 'package:tmdb_movies/utils/theam.dart';
import 'package:tmdb_movies/view/widgets/movie_frame.dart';



class NowPlayingMoviesScreen extends StatelessWidget {
  const NowPlayingMoviesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Movies',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.white,
                        blurRadius: 10,
                      ),
                    ],
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const  Padding(
              padding: EdgeInsets.only(left: 10, bottom: 8),
              child:  Text('Now playing Movies',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.white,
                        blurRadius: 4,
                      ),
                    ],
                  )),
            ),

           const SizedBox(height: 10,),
            MovieFrame(),

          ],
        ),
      ),
    );
  }
}
