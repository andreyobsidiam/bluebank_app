import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';
import 'package:bluebank_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<User> call({required String email, required String password}) {
    return _authRepository.login(email: email, password: password);
  }
}
