import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_state.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    authBloc = AuthBloc(mockLoginUseCase, mockLogoutUseCase);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password';
  final tUser = User(id: '1', email: tEmail);
  final tException = Exception('Failed');

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
}
