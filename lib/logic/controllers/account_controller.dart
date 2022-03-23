import 'dart:convert';

import 'package:get/get.dart';
import 'package:tmdb_movies/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_movies/models/account.dart';

class AccountController extends GetxController {
  AccountDetails? _account;
  // provider getters
  AccountDetails? get account => _account;


  Future getAccount(String sessionId) async {
    String url = Constants.baseUrl +
        Constants.accountDetails +
        Constants.key +
        '&session_id=$sessionId';

    print('account url $url');
    http.Response response = await http.get(Uri.parse(url));
    print('account response ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    _account = AccountDetails.fromJson(res);
    saveAccountIDAsPreferences();
  }




  void saveAccountIDAsPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accountID', _account!.id!);
  }
}
