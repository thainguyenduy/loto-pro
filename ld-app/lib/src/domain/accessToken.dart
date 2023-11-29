import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessToken {
  String? accessToken;
  final SharedPreferences _cache = locator<SharedPreferences>();
  AccessToken._(this.accessToken);
  factory AccessToken(String accessToken) {
    return AccessToken._(accessToken);
  }
  factory AccessToken.empty() {
    return AccessToken._(null);
  }
  AccessToken.fromCache() {
    accessToken = _cache.getString(
        dotenv.env['ACCESS_TOKEN_CACHE_KEY'] ?? '__access_token_cache_key__');
  }
  bool get isValid {
    if (accessToken == null) return false;
    try {
      // Verify a token (SecretKey for HMAC & PublicKey for all the others)
      final jwt = JWT.verify(
          accessToken!, SecretKey(dotenv.env['SECRET_PASSPHRASE'] ?? ''));

      print('Payload: ${jwt.payload}');
      return true;
    } on JWTExpiredException {
      print('jwt expired');
      return false;
    } on JWTException catch (ex) {
      print(ex.message); // ex: invalid signature
      return false;
    }
  }

  Future<void> save() async {
    if (accessToken != null) {
      await _cache.setString(
          dotenv.env['ACCESS_TOKEN_CACHE_KEY'] ?? '__access_token_cache_key__',
          accessToken ?? '');
    }
  }

  Future<void> clear() async {
    await _cache.remove(
        dotenv.env['ACCESS_TOKEN_CACHE_KEY'] ?? '__access_token_cache_key__');
    accessToken = null;
  }
}
