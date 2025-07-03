import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bluebank_app/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bluebank_app/src/features/auth/data/models/user_model.dart';
import 'package:bluebank_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockAuthRemoteDataSource);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password';
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
}
