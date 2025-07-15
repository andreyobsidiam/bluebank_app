import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({required User user}) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.otpSent() = _OtpSent;
  const factory AuthState.otpVerified() = _OtpVerified;
  const factory AuthState.passwordResetLinkSent() = _PasswordResetLinkSent;
  const factory AuthState.error({required String message}) = _Error;
  const factory AuthState.passwordUpdated() = _PasswordUpdated;
}
