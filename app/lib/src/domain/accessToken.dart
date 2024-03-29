import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessToken {
  String? accessToken;
  final SharedPreferences _cache = locator<SharedPreferences>();
  dynamic payload;
  bool? expired;
  AccessToken._(this.accessToken) {
    if (accessToken == null) return;
    _parse();
  }
  factory AccessToken(String accessToken) {
    return AccessToken._(accessToken);
  }
  factory AccessToken.empty() {
    return AccessToken._(null);
  }
  AccessToken.fromCache() {
    accessToken = _cache.getString(
        dotenv.env['ACCESS_TOKEN_CACHE_KEY'] ?? '__access_token_cache_key__');
    if (accessToken != null) _parse();
  }
  bool get isValid {
    return expired == false && accessToken != null;
  }

  _parse() {
    try {
      // Verify a token (SecretKey for HMAC & PublicKey for all the others)
      final jwt = JWT.verify(
          accessToken!, SecretKey(dotenv.env['SECRET_PASSPHRASE'] ?? ''));

      debugPrint('Payload: ${jwt.payload}');
      payload = jwt.payload;
      expired = false;
    } on JWTExpiredException {
      debugPrint('jwt expired');
      expired = true;
    } on JWTException catch (ex) {
      debugPrint(ex.message); // ex: invalid signature
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

  @override
  String toString() {
    return accessToken ?? '';
  }
}
