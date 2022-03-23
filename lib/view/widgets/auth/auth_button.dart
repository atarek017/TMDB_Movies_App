
import 'package:flutter/material.dart';
import 'package:tmdb_movies/utils/theam.dart';
import 'package:tmdb_movies/view/widgets/text_utils.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const AuthButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: mainColor,
        minimumSize: const Size(350, 50),
      ),
      child: TextUtils(
        text: text,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color:  Colors.white,
        underLine: TextDecoration.none,
      ),
    );
  }
}
