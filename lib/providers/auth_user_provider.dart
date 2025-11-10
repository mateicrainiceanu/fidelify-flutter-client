import 'package:fidelify_client/providers/api_service.dart';
import 'package:fidelify_client/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fidelify_client/models/auth_user.dart';

/// AuthUserProvider manages auth token and user data
class AuthUserProvider extends ChangeNotifier {
  static const _tokenKey = 'auth_token';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _token;
  AUser? _user;
  bool _cannotConnect = false;

  String? get token => _token;
  AUser? get user => _user;
  bool? get isLoggedIn => _token != null && _user != null;
  bool get cannotConnect => _cannotConnect;


  /// Initialize provider (e.g., on app start)
  Future<void> init() async {
    _cannotConnect = false;
    Log.trace("AuthUserProvider.init");
    _token = await _storage.read(key: _tokenKey);

    if (_token != null && _token!.isNotEmpty) {
      Log.info("AuthUserProvider.init - Found token: $_token");
      ApiService.instance.attachAuthProvider(this);
      await fetchUserData();
    }
  }

  /// Save token securely
  Future<void> setToken(String token) async {
    Log.info("Updating token");
    _token = token;
    await _storage.write(key: _tokenKey, value: token);
  }

  void setUser(AuthUser user) {
    _user = user.user;
    setToken(user.token);
    notifyListeners();
  }

  /// Remove token (logout)
  Future<void> clearToken() async {
    Log.info("Clearing token");
    _token = null;
    _user = null;
    await _storage.delete(key: _tokenKey);
    notifyListeners();
  }

  /// Fetch user data from API
  Future<void> fetchUserData() async {
    Log.info("AuthUserProvider.fetchUserData - Fetch user data");

    final response = await ApiService.instance.get<AUser>(path: "/api/v1/user-data", parser: AUser.fromJson);

    if (response.status == NetworkStatus.ok) {
      _user = response.val!;
      Log.info("User fetched: ${_user?.id}");
      notifyListeners();
    } else if (response.status == NetworkStatus.error && response.error?.code == 0) {
      _cannotConnect = true;
    } else {
      _user = null;
    }
    notifyListeners();
  }

  void logout() async {
    await clearToken();
  }
}