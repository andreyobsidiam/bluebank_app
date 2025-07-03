import 'package:bluebank_app/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';
import 'package:bluebank_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

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
}
