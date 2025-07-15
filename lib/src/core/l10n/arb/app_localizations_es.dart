// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get loginButton => 'Iniciar Sesión';

  @override
  String get emailHint => 'Correo Electrónico';

  @override
  String get emailOrLogon => 'Correo Electrónico o Logon';

  @override
  String get passwordHint => 'Contraseña';

  @override
  String get goodMorning => 'Buenos Días';

  @override
  String get goodAfternoon => 'Buenas Tardes';

  @override
  String get goodEvening => 'Buenas Noches';

  @override
  String get forgotPassword => 'Olvidé la contraseña';

  @override
  String get rememberWithFaceId => 'Recordar con Face ID';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get openAccount => 'Abrir cuenta';

  @override
  String get forgotPasswordTitle => 'Olvidé mi contraseña';

  @override
  String get enterYourRegisteredEmail =>
      'Ingresa tu correo electrónico registrado';

  @override
  String get emailRegisteredInBlueBank =>
      'Correo electrónico registrado en Blue Bank';

  @override
  String get weWillSendYouAnEmail =>
      'Te enviaremos un correo con un enlace a tu correo electrónico registrado para continuar con el proceso';

  @override
  String get sendLink => 'Enviar Enlace';

  @override
  String get otpCodeTitle => 'Código OTP';

  @override
  String get otpMessage =>
      'Te enviamos un código de 6 dígitos a tu correo electrónico vinculado a tu cuenta de Blue Bank';

  @override
  String get otpMessageBold =>
      'Te enviamos un código de 6 dígitos a tu correo electrónico';

  @override
  String get completeOtpMessage => 'Por favor, introduce el OTP completo';

  @override
  String get otpSentMessage => 'OTP enviado a tu correo electrónico';

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get resendCodeButton => 'Reenviar Código';

  @override
  String get linkExpired => 'El enlace ha expirado';

  @override
  String get passwordChanged => 'Tu contraseña ha sido cambiada exitosamente.';

  @override
  String get instructionsEmailTitle => 'Correo con instrucciones';

  @override
  String get instructionsSentTo => 'Se han enviado instrucciones a';

  @override
  String get instructionsToChangePassword =>
      'Se han enviado a tu bandeja de entrada las instrucciones para cambiar tu contraseña. Estate atento a los próximos pasos.';

  @override
  String get resendInstructions => 'Reenviar instrucciones';

  @override
  String resendInstructionsIn(Object seconds) {
    return 'Reenviar instrucciones en ($seconds segundos)';
  }

  @override
  String get invalidCredentials =>
      'Credenciales inválidas. Por favor, inténtalo de nuevo.';

  @override
  String get invalidOtp => 'OTP inválido. Por favor, inténtalo de nuevo.';
}
