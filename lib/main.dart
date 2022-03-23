import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_movies/logic/controllers/auth_controller.dart';
import 'package:tmdb_movies/routes/Routes.dart';
import 'package:tmdb_movies/utils/theam.dart';

import 'logic/controllers/account_controller.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final isLogged = await authLogin();
      runApp(MyApp(
        isLogged: isLogged,
      ));
    },
    (error, st) => print(error),
  );
}

class MyApp extends StatelessWidget {
  bool? isLogged;

  MyApp({this.isLogged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TMDB App',
      debugShowCheckedModeBanner: false,
      theme: ThemesApp.light,
      initialRoute: isLogged! ? Routes.mainScreen : Routes.authScreen,
      getPages: AppRoutes.routes,
    );
  }
}

Future<bool> authLogin() async {
  AuthController _authControl = Get.put(AuthController());
  AccountController _accountControl = Get.put(AccountController());

  final prefs = await SharedPreferences.getInstance();

  final isLogged = prefs.getBool('isLogged') ?? false;

  print(isLogged.toString());
  if (isLogged == true) {
    _authControl.sessionId = prefs.getString('sessionId') ?? "";
    _accountControl.account?.id = prefs.getInt('accountID');
  }

  return isLogged;
}
