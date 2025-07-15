import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({
    required String email,
    required String password,
  }) = _Login;
  const factory AuthEvent.logout() = _Logout;
  const factory AuthEvent.resetPassword({required String email}) =
      _ResetPassword;
  const factory AuthEvent.sendOtp({
    required String email,
    required String subject,
    required String templateId,
  }) = _SendOtp;

  const factory AuthEvent.verifyOtp({
    required String email,
    required String token,
  }) = _VerifyOtp;

  const factory AuthEvent.updatePassword({required String password}) =
      _UpdatePassword;
}
