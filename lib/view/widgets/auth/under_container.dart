import 'package:flutter/material.dart';
import 'package:tmdb_movies/utils/theam.dart';
import '../text_utils.dart';

class UnderContainer extends StatelessWidget {
  final String text;
  final String authType;
  final Function() onPressed;

  const UnderContainer(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.authType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: _height * .127,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtils(
              text: text,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              underLine: TextDecoration.none),
          TextButton(
            onPressed: onPressed,
            child: TextUtils(
                text: authType,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                underLine: TextDecoration.underline),
          )
        ],
      ),
    );
  }
}
