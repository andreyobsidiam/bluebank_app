import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';
import 'package:bluebank_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUseCase(mockAuthRepository);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password';
  final tUser = User(id: '1', email: tEmail);

  test('should get user from the repository', () async {
    // arrange
    when(
      () => mockAuthRepository.login(email: tEmail, password: tPassword),
    ).thenAnswer((_) async => tUser);
    // act
    final result = await usecase(email: tEmail, password: tPassword);
    // assert
    expect(result, tUser);
    verify(() => mockAuthRepository.login(email: tEmail, password: tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
