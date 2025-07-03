import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:bluebank_app/src/features/post/domain/entities/post.dart';

part 'api_client.g.dart';

@RestApi()
@lazySingleton
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @GET('/posts')
  Future<List<Post>> getPosts();

  @GET('/posts/{id}')
  Future<Post> getPostDetail(@Path('id') int id);

  @POST('/posts')
  Future<Post> createPost(@Body() Post post);
}
