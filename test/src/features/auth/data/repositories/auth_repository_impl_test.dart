import 'package:bluebank_app/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bluebank_app/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bluebank_app/src/features/auth/data/models/user_model.dart';
import 'package:bluebank_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      mockAuthRemoteDataSource,
      mockAuthLocalDataSource,
    );
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password';
  const tOtp = '123456';
  final tUserModel = UserModel(id: '1', email: tEmail);
  final User tUser = tUserModel.toEntity();

  group('login', () {
    test(
      'should return User when the call to remote data source is successful',
      () async {
        // arrange
        when(
          () => mockAuthRemoteDataSource.login(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => tUserModel);
        // act
        final result = await repository.login(
          email: tEmail,
          password: tPassword,
        );
        // assert
        expect(result, tUser);
        verify(
          () => mockAuthRemoteDataSource.login(
            email: tEmail,
            password: tPassword,
          ),
        );
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );

    test(
      'should throw an exception when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          () => mockAuthRemoteDataSource.login(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(Exception());
        // act
        final call = repository.login;
        // assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<Exception>()),
        );
      },
    );
  });

  group('logout', () {
    test('should call logout on the remote data source', () async {
      // arrange
      when(() => mockAuthRemoteDataSource.logout()).thenAnswer((_) async {});
      // act
      await repository.logout();
      // assert
      verify(() => mockAuthRemoteDataSource.logout()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });
  });

  group('sendOtp', () {
    const tSubject = 'subject';
    const tTemplateId = 'template_id';
    test('should get otp from remote and save it to local', () async {
      // arrange
      when(
        () => mockAuthRemoteDataSource.sendOtp(
          email: tEmail,
          subject: tSubject,
          templateId: tTemplateId,
        ),
      ).thenAnswer((_) async => tOtp);
      when(
        () => mockAuthLocalDataSource.saveOtp(tOtp),
      ).thenAnswer((_) async => {});
      // act
      await repository.sendOtp(
        email: tEmail,
        subject: tSubject,
        templateId: tTemplateId,
      );
      // assert
      verify(
        () => mockAuthRemoteDataSource.sendOtp(
          email: tEmail,
          subject: tSubject,
          templateId: tTemplateId,
        ),
      ).called(1);
      verify(() => mockAuthLocalDataSource.saveOtp(tOtp)).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
      verifyNoMoreInteractions(mockAuthLocalDataSource);
    });
  });

  group('verifyOtp', () {
    test('should call remote datasource when otp is correct', () async {
      // arrange
      when(
        () => mockAuthLocalDataSource.getOtp(),
      ).thenAnswer((_) async => tOtp);
      when(
        () => mockAuthRemoteDataSource.verifyOtp(email: tEmail, token: tOtp),
      ).thenAnswer((_) async => {});
      // act
      await repository.verifyOtp(token: tOtp);
      // assert
      verify(() => mockAuthLocalDataSource.getOtp()).called(1);
      verify(
        () => mockAuthRemoteDataSource.verifyOtp(email: tEmail, token: tOtp),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
      verifyNoMoreInteractions(mockAuthLocalDataSource);
    });

    test('should throw exception when otp is incorrect', () async {
      // arrange
      when(
        () => mockAuthLocalDataSource.getOtp(),
      ).thenAnswer((_) async => 'wrong_otp');
      // act
      final call = repository.verifyOtp;
      // assert
      expect(() => call(token: tOtp), throwsA(isA<Exception>()));
      verify(() => mockAuthLocalDataSource.getOtp()).called(1);
      verifyNoMoreInteractions(mockAuthLocalDataSource);
      verifyZeroInteractions(mockAuthRemoteDataSource);
    });
  });
}
