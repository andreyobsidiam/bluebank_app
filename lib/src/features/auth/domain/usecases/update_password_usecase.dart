import 'package:bluebank_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePasswordUseCase {
  final AuthRepository _authRepository;

  UpdatePasswordUseCase(this._authRepository);

  Future<void> call({required String password}) {
    return _authRepository.updatePassword(email: '', password: password);
  }
}
