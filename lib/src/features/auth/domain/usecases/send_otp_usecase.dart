import 'package:bluebank_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendOtpUseCase {
  final AuthRepository _authRepository;

  SendOtpUseCase(this._authRepository);

  Future<void> call({required String email}) {
    return _authRepository.sendOtp(email: email);
  }
}
