class Constants{
  static const String key = 'api_key=31521ab741626851b73c684539c33b5a';

  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String requestToken='authentication/token/new?';
  static const String validateToken='authentication/token/validate_with_login?';
  static const String createSession='authentication/session/new?';

  static const String accountDetails='account?';
  static const String nowPlaying='movie/now_playing?';

  static final Map<String, String> requestHeader = {
    'Content-Type': 'application/json'
  };

}


