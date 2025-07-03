import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bluebank_app/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bluebank_app/src/features/auth/data/models/user_model.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    dataSource = AuthRemoteDataSourceImpl(mockSupabaseClient);

    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password';
  final tUserModel = UserModel(id: '1', email: tEmail);
  final tUser = MockUser();

  group('login', () {
    test(
      'should return UserModel when the call to Supabase is successful',
      () async {
        // arrange
        when(() => tUser.id).thenReturn('1');
        when(() => tUser.email).thenReturn(tEmail);
        when(
          () => mockGoTrueClient.signInWithPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => AuthResponse(user: tUser));
        // act
        final result = await dataSource.login(
          email: tEmail,
          password: tPassword,
        );
        // assert
        expect(result, tUserModel);
        verify(
          () => mockGoTrueClient.signInWithPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockGoTrueClient);
      },
    );

    test(
      'should throw an Exception when the call to Supabase is unsuccessful',
      () async {
        // arrange
        when(
          () => mockGoTrueClient.signInWithPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => AuthResponse());
        // act
        final call = dataSource.login;
        // assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<Exception>()),
        );
      },
    );
  });

  group('logout', () {
    test('should call Supabase signOut', () async {
      // arrange
      when(() => mockGoTrueClient.signOut()).thenAnswer((_) async {});
      // act
      await dataSource.logout();
      // assert
      verify(() => mockGoTrueClient.signOut()).called(1);
      verifyNoMoreInteractions(mockGoTrueClient);
    });
  });
}
