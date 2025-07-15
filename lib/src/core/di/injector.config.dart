// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i852;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/reset_password_usecase.dart'
    as _i474;
import '../../features/auth/domain/usecases/send_otp_usecase.dart' as _i663;
import '../../features/auth/domain/usecases/update_password_usecase.dart'
    as _i387;
import '../../features/auth/domain/usecases/verify_otp_usecase.dart' as _i503;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/localization/data/datasources/language_local_data_source.dart'
    as _i178;
import '../../features/localization/data/repositories/language_repository_impl.dart'
    as _i48;
import '../../features/localization/domain/repositories/language_repository.dart'
    as _i1031;
import '../../features/localization/presentation/bloc/localization_bloc.dart'
    as _i459;
import '../../features/post/data/adapters/http/api_client.dart' as _i357;
import '../../features/post/data/datasources/post_remote_data_source.dart'
    as _i297;
import '../../features/post/data/repositories/post_repository_impl.dart'
    as _i1039;
import '../../features/post/domain/repositories/post_repository.dart' as _i786;
import '../../features/post/domain/usecases/get_posts.dart' as _i472;
import '../../features/post/presentation/bloc/post_bloc.dart' as _i896;
import '../network/dio_client.dart' as _i667;
import 'register_module.dart' as _i291;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  final dioClient = _$DioClient();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
  gh.lazySingleton<_i361.Dio>(() => dioClient.dio);
  gh.lazySingleton<_i178.LanguageLocalDataSource>(
    () => _i178.LanguageLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
  );
  gh.lazySingleton<_i357.ApiClient>(() => _i357.ApiClient(gh<_i361.Dio>()));
  gh.lazySingleton<_i852.AuthLocalDataSource>(
    () => _i852.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
  );
  gh.lazySingleton<_i107.AuthRemoteDataSource>(
    () => _i107.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
  );
  gh.lazySingleton<_i297.PostRemoteDataSource>(
    () => _i297.PostRemoteDataSourceImpl(gh<_i357.ApiClient>()),
  );
  gh.lazySingleton<_i1031.LanguageRepository>(
    () => _i48.LanguageRepositoryImpl(gh<_i178.LanguageLocalDataSource>()),
  );
  gh.lazySingleton<_i786.PostRepository>(
    () => _i1039.PostRepositoryImpl(gh<_i297.PostRemoteDataSource>()),
  );
  gh.lazySingleton<_i787.AuthRepository>(
    () => _i153.AuthRepositoryImpl(
      gh<_i107.AuthRemoteDataSource>(),
      gh<_i852.AuthLocalDataSource>(),
    ),
  );
  gh.lazySingleton<_i472.GetPosts>(
    () => _i472.GetPosts(gh<_i786.PostRepository>()),
  );
  gh.factory<_i474.ResetPasswordUseCase>(
    () => _i474.ResetPasswordUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i459.LocalizationBloc>(
    () => _i459.LocalizationBloc(gh<_i1031.LanguageRepository>()),
  );
  gh.factory<_i896.PostBloc>(() => _i896.PostBloc(gh<_i472.GetPosts>()));
  gh.factory<_i188.LoginUseCase>(
    () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i48.LogoutUseCase>(
    () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i663.SendOtpUseCase>(
    () => _i663.SendOtpUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i503.VerifyOtpUseCase>(
    () => _i503.VerifyOtpUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i387.UpdatePasswordUseCase>(
    () => _i387.UpdatePasswordUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i797.AuthBloc>(
    () => _i797.AuthBloc(
      gh<_i188.LoginUseCase>(),
      gh<_i48.LogoutUseCase>(),
      gh<_i474.ResetPasswordUseCase>(),
      gh<_i663.SendOtpUseCase>(),
      gh<_i503.VerifyOtpUseCase>(),
      gh<_i387.UpdatePasswordUseCase>(),
    ),
  );
  return getIt;
}

class _$RegisterModule extends _i291.RegisterModule {}

class _$DioClient extends _i667.DioClient {}
