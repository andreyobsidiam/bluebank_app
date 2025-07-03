import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bluebank_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:bluebank_app/src/features/auth/domain/usecases/logout_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LogoutUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LogoutUseCase(mockAuthRepository);
  });

  test('should call logout on the repository', () async {
    // arrange
    when(
      () => mockAuthRepository.logout(),
    ).thenAnswer((_) async => Future.value());
    // act
    await usecase();
    // assert
    verify(() => mockAuthRepository.logout());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
