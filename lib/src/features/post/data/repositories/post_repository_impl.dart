import 'package:injectable/injectable.dart';
import 'package:bluebank_app/src/features/post/data/datasources/post_remote_data_source.dart';
import 'package:bluebank_app/src/features/post/domain/entities/post.dart';
import 'package:bluebank_app/src/features/post/domain/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _remoteDataSource;

  PostRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Post>> getPosts() {
    return _remoteDataSource.getPosts();
  }

  @override
  Future<Post> getPostDetail(int id) {
    return _remoteDataSource.getPostDetail(id);
  }

  @override
  Future<Post> createPost(Post post) {
    return _remoteDataSource.createPost(post);
  }
}
