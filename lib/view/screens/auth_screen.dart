import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_movies/logic/controllers/account_controller.dart';
import 'package:tmdb_movies/logic/controllers/auth_controller.dart';
import 'package:tmdb_movies/logic/controllers/movies_controller.dart';
import 'package:tmdb_movies/models/auth_erorr.dart';
import 'package:tmdb_movies/routes/Routes.dart';
import 'package:tmdb_movies/utils/theam.dart';
import 'package:tmdb_movies/view/widgets/auth/auth_button.dart';
import 'package:tmdb_movies/view/widgets/auth/auth_text_form_field.dart';
import 'package:tmdb_movies/view/widgets/auth/under_container.dart';
import 'package:tmdb_movies/view/widgets/loading_progres.dart';
import 'package:tmdb_movies/view/widgets/text_utils.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _authControl = Get.find<AuthController>();
  final _accountControl = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: double.infinity,
                height: _height / 1.3,
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 40),
                    // Form
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          // LOG IN text
                          Row(
                            children:  [
                              TextUtils(
                                text: "LOG",
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: mainColor,
                                underLine: TextDecoration.none,

                              ),
                             const  SizedBox(
                                width: 3,
                              ),
                              TextUtils(
                                text: "IN",
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                underLine: TextDecoration.none,
                              ),
                            ],
                          ),

                          const SizedBox(height: 50),

                          // Email
                          AuthTextFormField(
                              controller: emailController,
                              obscureText: false,
                              validator: (value) {},
                              prefixIcon: const Icon(
                                Icons.email,
                                color: mainColor,
                                size: 30,
                              ),
                              suffixIcon: const SizedBox(),
                              hintText: "Email"),

                          const SizedBox(height: 20),

                          // Pass Word

                          GetBuilder<AuthController>(
                            builder: (_) {
                              return AuthTextFormField(
                                  controller: passwordController,
                                  obscureText:
                                      _authControl.isVisible ? false : true,
                                  validator: (value) {},
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: mainColor,
                                    size: 30,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _authControl.passWordVisibility();
                                    },
                                    icon: _authControl.isVisible
                                        ? const Icon(
                                            Icons.visibility,
                                            color: Colors.black,
                                          )
                                        : const Icon(
                                            Icons.visibility_off,
                                            color: Colors.black,
                                          ),
                                  ),
                                  hintText: "Password");
                            },
                          ),

                          SizedBox(
                            height: _height * .12,
                          ),

                          // Login Button
                          AuthButton(
                            onPressed: () {
                              authenticationLogic(context);
                            },
                            text: "LOG IN",
                          ),
                        ],
                      ),
                    )),
              ),

              // Skip Login
              UnderContainer(
                text: "Don't have an account?",
                authType: 'Skip Login',
                onPressed: () {
                  Get.offNamed(Routes.mainScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void authenticationLogic(_context) async {
    _authControl.name = emailController.text;
    _authControl.pass = passwordController.text;
    dynamic result = await _authControl.getRequestToken();

    if (result is AuthError) {
      Dialogs.showErrorDialog(_context,
          message: result.statusMessage!, code: result.statusCode!);
      print('results ${result.toString()}');
    }else{
      var logResult;

      await _authControl.login().then((result) {
        logResult = result;
      });
      if (logResult is bool) {
        if (logResult) {
          await _authControl.createSession();
          await _accountControl.getAccount(_authControl.sessionId);

          // await _accountControl.getFavoriteMovies(_authControl.sessionId);
          // await _accountControl.getFavoriteTvs(_authControl.sessionId);


          Get.offNamed(Routes.mainScreen);

        } else {

          Dialogs.showErrorDialog(_context,
              message: "un known Error ", code: 400);
        }
      } else if (logResult is AuthError) {
        Dialogs.showErrorDialog(_context,
            message: logResult.statusMessage!, code: logResult.statusCode!);
      }
    }



  }
}
