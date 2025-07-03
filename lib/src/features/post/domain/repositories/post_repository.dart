import 'package:bluebank_app/src/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Post> getPostDetail(int id);
  Future<Post> createPost(Post post);
}
