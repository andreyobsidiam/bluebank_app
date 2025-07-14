import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_state.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

class MockSendOtpUseCase extends Mock implements SendOtpUseCase {}

class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockSendOtpUseCase mockSendOtpUseCase;
  late MockVerifyOtpUseCase mockVerifyOtpUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockSendOtpUseCase = MockSendOtpUseCase();
    mockVerifyOtpUseCase = MockVerifyOtpUseCase();
    authBloc = AuthBloc(
      mockLoginUseCase,
      mockLogoutUseCase,
      mockResetPasswordUseCase,
      mockSendOtpUseCase,
      mockVerifyOtpUseCase,
    );
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password';
  final tUser = User(id: '1', email: tEmail);
  final tException = Exception('Failed');
  const tToken = '123456';

  test('initial state is AuthState.initial', () {
    expect(authBloc.state, const AuthState.initial());
  });

  group('LoginEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when login is successful',
      build: () {
        when(
          () => mockLoginUseCase(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => tUser);
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthEvent.login(email: tEmail, password: tPassword)),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(user: tUser),
      ],
      verify: (_) {
        verify(
          () => mockLoginUseCase(email: tEmail, password: tPassword),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when login fails',
      build: () {
        when(
          () => mockLoginUseCase(email: tEmail, password: tPassword),
        ).thenThrow(tException);
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthEvent.login(email: tEmail, password: tPassword)),
      expect: () => [
        const AuthState.loading(),
        AuthState.error(message: tException.toString()),
      ],
    );
  });

  group('LogoutEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, unauthenticated] when logout is successful',
      build: () {
        when(() => mockLogoutUseCase()).thenAnswer((_) async => Future.value());
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.logout()),
      expect: () => [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
      ],
      verify: (_) {
        verify(() => mockLogoutUseCase()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when logout fails',
      build: () {
        when(() => mockLogoutUseCase()).thenThrow(tException);
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.logout()),
      expect: () => [
        const AuthState.loading(),
        AuthState.error(message: tException.toString()),
      ],
    );
  });

  group('ResetPasswordEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, unauthenticated] when reset password is successful',
      build: () {
        when(
          () => mockResetPasswordUseCase(email: tEmail),
        ).thenAnswer((_) async => Future.value());
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.resetPassword(email: tEmail)),
      expect: () => [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
      ],
      verify: (_) {
        verify(() => mockResetPasswordUseCase(email: tEmail)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when reset password fails',
      build: () {
        when(
          () => mockResetPasswordUseCase(email: tEmail),
        ).thenThrow(tException);
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.resetPassword(email: tEmail)),
      expect: () => [
        const AuthState.loading(),
        AuthState.error(message: tException.toString()),
      ],
    );
  });

  group('SendOtpEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, otpSent] when send otp is successful',
      build: () {
        when(
          () => mockSendOtpUseCase(email: tEmail),
        ).thenAnswer((_) async => Future.value());
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.sendOtp(email: tEmail)),
      expect: () => [const AuthState.loading(), const AuthState.otpSent()],
      verify: (_) {
        verify(() => mockSendOtpUseCase(email: tEmail)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when send otp fails',
      build: () {
        when(() => mockSendOtpUseCase(email: tEmail)).thenThrow(tException);
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.sendOtp(email: tEmail)),
      expect: () => [
        const AuthState.loading(),
        AuthState.error(message: tException.toString()),
      ],
    );
  });

  group('VerifyOtpEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when verify otp is successful',
      build: () {
        when(
          () => mockVerifyOtpUseCase(email: tEmail, token: tToken),
        ).thenAnswer((_) async => Future.value());
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthEvent.verifyOtp(email: tEmail, token: tToken)),
      expect: () => [const AuthState.loading()],
      verify: (_) {
        verify(
          () => mockVerifyOtpUseCase(email: tEmail, token: tToken),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when verify otp fails',
      build: () {
        when(
          () => mockVerifyOtpUseCase(email: tEmail, token: tToken),
        ).thenThrow(tException);
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthEvent.verifyOtp(email: tEmail, token: tToken)),
      expect: () => [
        const AuthState.loading(),
        AuthState.error(message: tException.toString()),
      ],
    );
  });
}
