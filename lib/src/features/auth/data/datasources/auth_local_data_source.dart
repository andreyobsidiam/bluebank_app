import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveOtp(String otp);
  Future<String?> getOtp();
  Future<bool> verifyOtp({required String token});
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  AuthLocalDataSourceImpl(this._sharedPreferences);

  static const _otpKey = 'otp';

  @override
  Future<String?> getOtp() async {
    return _sharedPreferences.getString(_otpKey);
  }

  @override
  Future<void> saveOtp(String otp) async {
    await _sharedPreferences.setString(_otpKey, otp);
  }

  @override
  Future<bool> verifyOtp({required String token}) async {
    final savedOtp = await getOtp();
    return savedOtp == token;
  }
}
