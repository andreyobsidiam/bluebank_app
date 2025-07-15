import 'package:bluebank_app/src/features/auth/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<void> resetPassword({required String email});
  Future<String> sendOtp({required String email});
  Future<void> verifyOtp({required String email, required String token});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) {
      throw Exception('Login failed');
    }
    return UserModel(id: user.id, email: user.email!);
  }

  @override
  Future<void> logout() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _supabaseClient.auth.resetPasswordForEmail(email);
  }

  @override
  Future<String> sendOtp({required String email}) async {
    try {
      final response = await _supabaseClient.functions.invoke(
        'send-otp',
        body: {'email': email},
      );

      if (response.status != 200) {
        throw Exception('Failed to send OTP');
      }

      final data = response.data;
      if (data == null || data['otp'] == null) {
        throw Exception('Invalid response from function');
      }

      return data['otp'];
    } catch (e) {
      if (kDebugMode) {
        print('Error invoking OTP function: $e');
      }
      throw Exception('Failed to send OTP: $e');
    }
  }

  @override
  Future<void> verifyOtp({required String email, required String token}) async {
    // This logic seems to be local. If it needs to be remote,
    // it should be adapted. For now, assuming it's correct as is.
    await _supabaseClient.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.email,
    );
  }
}
