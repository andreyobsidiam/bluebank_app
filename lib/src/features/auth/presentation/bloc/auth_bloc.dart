import 'package:bluebank_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;
import 'package:injectable/injectable.dart';

import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final UpdatePasswordUseCase _updatePasswordUseCase;

  AuthBloc(
    this._loginUseCase,
    this._logoutUseCase,
    this._resetPasswordUseCase,
    this._sendOtpUseCase,
    this._verifyOtpUseCase,
    this._updatePasswordUseCase,
  ) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        login: (email, password) async {
          emit(const AuthState.loading());
          try {
            final user = await _loginUseCase(email: email, password: password);
            emit(AuthState.authenticated(user: user));
          } catch (e) {
            if (e.toString().contains('invalid_credentials')) {
              emit(const AuthState.invalidCredentials());
            } else {
              emit(AuthState.error(message: e.toString()));
            }
          }
        },
        logout: () async {
          emit(const AuthState.loading());
          try {
            await _logoutUseCase();
            emit(const AuthState.unauthenticated());
          } catch (e) {
            emit(AuthState.error(message: e.toString()));
          }
        },
        resetPassword: (email) async {
          emit(const AuthState.loading());
          try {
            await _resetPasswordUseCase(email: email);
            emit(const AuthState.passwordResetLinkSent());
          } catch (e) {
            emit(AuthState.error(message: e.toString()));
          }
        },
        sendOtp: (email, subject, templateId) async {
          emit(const AuthState.loading());
          try {
            await _sendOtpUseCase(
              email: email,
              subject: subject,
              templateId: templateId,
            );
            emit(const AuthState.otpSent());
          } catch (e) {
            emit(AuthState.error(message: e.toString()));
          }
        },
        verifyOtp: (email, token) async {
          emit(const AuthState.loading());
          try {
            // This will automatically sign in the user.
            await _verifyOtpUseCase(email: email, token: token);
            emit(const AuthState.otpVerified()); // User is authenticated
          } catch (e) {
            if (e.toString().contains('invalid_otp')) {
              emit(const AuthState.error(message: 'invalid_otp'));
            } else {
              emit(AuthState.error(message: e.toString()));
            }
          }
        },

        updatePassword: (password) async {
          emit(const AuthState.loading());
          try {
            await _updatePasswordUseCase(password: password);
            emit(const AuthState.passwordUpdated());
          } catch (e) {
            emit(AuthState.error(message: e.toString()));
          }
        },
      );
    });
  }
}
