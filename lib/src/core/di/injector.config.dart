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

import '../../features/post/data/datasources/post_remote_data_source.dart'
    as _i297;
import '../../features/post/data/adapters/http/api_client.dart' as _i626;
import '../../features/post/data/repositories/post_repository_impl.dart'
    as _i1039;
import '../../features/post/domain/repositories/post_repository.dart' as _i786;
import '../../features/post/domain/usecases/get_posts.dart' as _i472;
import '../../features/post/presentation/bloc/post_bloc.dart' as _i896;
import '../network/dio_client.dart' as _i667;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final dioClient = _$DioClient();
  gh.lazySingleton<_i361.Dio>(() => dioClient.dio);
  gh.lazySingleton<_i626.ApiClient>(() => _i626.ApiClient(gh<_i361.Dio>()));
  gh.lazySingleton<_i297.PostRemoteDataSource>(
    () => _i297.PostRemoteDataSourceImpl(gh<_i626.ApiClient>()),
  );
  gh.lazySingleton<_i786.PostRepository>(
    () => _i1039.PostRepositoryImpl(gh<_i297.PostRemoteDataSource>()),
  );
  gh.lazySingleton<_i472.GetPosts>(
    () => _i472.GetPosts(gh<_i786.PostRepository>()),
  );
  gh.factory<_i896.PostBloc>(() => _i896.PostBloc(gh<_i472.GetPosts>()));
  return getIt;
}

class _$DioClient extends _i667.DioClient {}
