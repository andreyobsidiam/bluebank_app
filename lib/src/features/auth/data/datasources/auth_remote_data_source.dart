import 'dart:math';

import 'package:bluebank_app/src/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
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
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._supabaseClient, this._dio);

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
    final otp = (100000 + Random().nextInt(900000)).toString();
    const url = 'https://api.mailersend.com/v1/email';
    const token =
        'mlsn.867cf33b8c55175c574e8718cb390632efe12ada816b7e92a51ece190f4a3070';
    try {
      await _dio.post(
        url,
        data: {
          "from": {"email": "test@test-eqvygm0j3q5l0p7w.mlsender.net"},
          "to": [
            {"email": email},
          ],
          "subject": "One Time Password",
          "personalization": [
            {
              "email": email,
              "data": {"variable": otp},
            },
          ],
          "template_id": "yzkq340k16xgd796",
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return otp;
    } catch (e) {
      if (kDebugMode) {
        print('Error sending OTP: $e');
      }
      throw Exception('Failed to send OTP: $e');
    }
  }

  @override
  Future<void> verifyOtp({required String email, required String token}) async {
    await _supabaseClient.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.email,
    );
  }
}
