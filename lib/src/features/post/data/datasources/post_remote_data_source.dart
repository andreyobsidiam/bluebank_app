import 'package:injectable/injectable.dart';
import 'package:bluebank_app/src/features/post/data/adapters/http/api_client.dart';
import 'package:bluebank_app/src/features/post/domain/entities/post.dart';

abstract class PostRemoteDataSource {
  Future<List<Post>> getPosts();
  Future<Post> getPostDetail(int id);
  Future<Post> createPost(Post post);
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final ApiClient _apiClient;

  PostRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<Post>> getPosts() {
    return _apiClient.getPosts();
  }

  @override
  Future<Post> getPostDetail(int id) {
    return _apiClient.getPostDetail(id);
  }

  @override
  Future<Post> createPost(Post post) {
    return _apiClient.createPost(post);
  }
}
