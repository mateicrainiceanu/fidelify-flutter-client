import 'package:fidelify_client/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppPreferencesProvider extends ChangeNotifier {
  bool _initialized = false;
  bool get initialized => _initialized;

  bool _isShopOwner = false;
  bool get isShopOwner => _isShopOwner;

  final FlutterSecureStorage _fss = const FlutterSecureStorage();

  AppPreferencesProvider() {
    initialize();
  }

  Future<void> initialize() async {

    Log.trace("Initializing app preferences");
    _isShopOwner = await _fss.read(key: 'isShopOwner') == 'true';

    _initialized = true;
    notifyListeners();
  }

  Future<void> setShopOwner(bool value) async {
    _isShopOwner = value;
    Log.trace("setShopOwner -> $value");
    notifyListeners();

    // Persist change
    await _fss.write(key: 'isShopOwner', value: value.toString());
  }

}