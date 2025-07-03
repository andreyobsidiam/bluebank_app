import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});
  Future<void> logout();
  Future<void> resetPassword({required String email});
}
