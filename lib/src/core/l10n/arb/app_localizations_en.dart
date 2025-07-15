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
  String get emailOrLogon => 'Email or Logon';

  @override
  String get passwordHint => 'Password';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get forgotPassword => 'I forgot the password';

  @override
  String get rememberWithFaceId => 'Remember with face ID';

  @override
  String get signIn => 'Sign In';

  @override
  String get openAccount => 'Open account';

  @override
  String get forgotPasswordTitle => 'Forgot password';

  @override
  String get enterYourRegisteredEmail => 'Enter your registered email';

  @override
  String get emailRegisteredInBlueBank => 'Email registered in Blue Bank';

  @override
  String get weWillSendYouAnEmail =>
      'We will send you an email with a link to your registered email to continue the process';

  @override
  String get sendLink => 'Send Link';

  @override
  String get otpCodeTitle => 'OTP Code';

  @override
  String get otpMessage =>
      'We sent you a 6-digit code to your email linked to your Blue Bank account';

  @override
  String get otpMessageBold => 'We sent you a 6-digit code to your email';

  @override
  String get completeOtpMessage => 'Please enter the complete OTP';

  @override
  String get otpSentMessage => 'OTP sent to your email';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get resendCodeButton => 'Resend Code';

  @override
  String get linkExpired => 'The link has expired';

  @override
  String get passwordChanged => 'Your password has been successfully changed.';

  @override
  String get instructionsEmailTitle => 'Instructions email';

  @override
  String get instructionsSentTo => 'Instructions has been sent to';

  @override
  String get instructionsToChangePassword =>
      'Instructions to change your password has been set to your inbox. Be on the lookout for the next steps.';

  @override
  String get resendInstructions => 'Resend Instructions';

  @override
  String resendInstructionsIn(Object seconds) {
    return 'Resend Instructions ($seconds seconds)';
  }
}
