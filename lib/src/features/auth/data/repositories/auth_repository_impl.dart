import 'package:bluebank_app/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bluebank_app/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';
import 'package:bluebank_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<User> login({required String email, required String password}) async {
    final userModel = await _authRemoteDataSource.login(
      email: email,
      password: password,
    );
    return userModel.toEntity();
  }

  @override
  Future<void> logout() {
    return _authRemoteDataSource.logout();
  }

  @override
  Future<void> resetPassword({required String email}) {
    return _authRemoteDataSource.resetPassword(email: email);
  }

  @override
  Future<void> sendOtp({
    required String email,
    required String subject,
    required String templateId,
  }) async {
    final otp = await _authRemoteDataSource.sendOtp(
      email: email,
      subject: subject,
      templateId: templateId,
    );
    await _authLocalDataSource.saveOtp(otp);
  }

  @override
  Future<void> verifyOtp({required String token}) async {
    final isVerified = await _authLocalDataSource.verifyOtp(token: token);
    if (!isVerified) {
      throw Exception('invalid_otp');
    }
  }

  @override
  Future<void> updatePassword({
    required String email,
    required String password,
  }) {
    return _authRemoteDataSource.updatePassword(password: password);
  }
}
