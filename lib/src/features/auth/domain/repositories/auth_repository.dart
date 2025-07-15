import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});
  Future<void> logout();
  Future<void> resetPassword({required String email});
  Future<void> sendOtp({
    required String email,
    required String subject,
    required String templateId,
  });
  Future<void> verifyOtp({required String token});

  Future<void> updatePassword({
    required String email,
    required String password,
  });
}
