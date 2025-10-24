// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Fidelify';

  @override
  String get authLogin => 'Login';

  @override
  String get authRegister => 'Register';

  @override
  String get authDontHaveAccountRegister =>
      'Don\'t have an account? Register here';

  @override
  String get authAlreadyHaveAccountLogin =>
      'Already have an account? Login here';

  @override
  String get authPassword => 'Password';

  @override
  String get authRegistrationSuccess => 'Registration successful!';

  @override
  String get authLoginSuccess => 'Login successful!';

  @override
  String get authLogoutSuccess => 'Logout successful';

  @override
  String get userFname => 'First Name';

  @override
  String get userLname => 'Last Name';

  @override
  String get userEmail => 'Email';

  @override
  String get userPhone => 'Phone Number';

  @override
  String get userBdate => 'Birth Date';

  @override
  String get userPassword => 'Password';
}
