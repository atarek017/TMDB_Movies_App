import 'dart:convert';

import 'package:get/get.dart';
import 'package:tmdb_movies/constants/constants.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_movies/models/auth.dart';
import 'package:tmdb_movies/models/auth_erorr.dart';
import 'package:tmdb_movies/models/request_token.dart';

class AuthController extends GetxController {
  bool isVisible = false;
  late RequestToken _requestToken;
  late AuthError _requestTokenError;
  late AuthModel _authModel;
  late String _sessionId;
  bool _isLoading = false;

  String? _name;
  String? _pass;

  String get name => _name!;

  set name(String value) => _name = value;

  String get pass => _pass!;

  set sessionId(String value) => _sessionId = value;

  String get sessionId => _sessionId;

  set pass(String value) => _pass = value;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  void passWordVisibility() {
    isVisible = !isVisible;
    update();
  }

  Future<dynamic> getRequestToken() async {
    _isLoading = true;
    update();

    print('Starting token request');

    String url = Constants.baseUrl + Constants.requestToken + Constants.key;

    http.Response response = await http.get(Uri.parse(url));

    print('Completed token request');
    print('token data : ${response.body}');

    var res = json.decode(response.body);


    if (res['success']) {
      _requestToken = RequestToken.fromJson(res);
      print('token granted built requestToken');

      return true;
    }
    _requestTokenError = AuthError.fromJson(res);

    _isLoading=false;
    update();

    print('token NOt granted built requestTokenError');
    return _requestTokenError;
  }


  Future<dynamic> login() async {
    if (_requestToken == null) return false;
    _isLoading = true;
    update();
    print('Starting login request');


    Map<String, String> body = {
      'username': _name!,
      'password': _pass!,
      'request_token': _requestToken.requestToken!
    };

    String url = Constants.baseUrl + Constants.validateToken + Constants.key;

    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode(body), headers: Constants.requestHeader);

    print('Completed login request');
    print('login data : ${response.body}');


    Map<String, dynamic> res = json.decode(response.body);


    if (res.containsKey('success') && res['success']) {
      _authModel = AuthModel.fromJson(res);
      return true;
    } else {
      _isLoading=false;
      update();

      return AuthError.fromJson(res);
    }
  }

  Future<dynamic> createSession() async {
    _isLoading=true;
    update();
    print('Starting session request');


    Map<String, String> body = {'request_token': _requestToken.requestToken!};

    String url = Constants.baseUrl + Constants.createSession + Constants.key;

    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: Constants.requestHeader,
    );
    print('Completed session request');
    print('session respond  : ${response.body}');


    Map<String, dynamic> res = json.decode(response.body);

    _isLoading=true;
    update();

    if (res.containsKey('success') && res['success']) {
      _sessionId = res['session_id'];
      // Save Session ID;
      saveSessionIDAsPreferences();
      print('got session $_sessionId');
      return true;
    }
    return AuthError.fromJson(res);
  }

  void saveSessionIDAsPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessionId', _sessionId);
    await prefs.setBool('isLogged', true);
  }
}
