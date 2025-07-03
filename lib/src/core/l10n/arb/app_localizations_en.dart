// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginButton => 'Login';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get forgotPassword => 'I forgot the password';

  @override
  String get rememberWithFaceId => 'Remember with face ID';

  @override
  String get signIn => 'Sign In';

  @override
  String get openAccount => 'Open account';
}
