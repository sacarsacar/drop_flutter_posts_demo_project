import 'package:posts_demo_project/features/posts/data/models/posts_model.dart';

abstract class PostsRepositories {
  Future<List<Post>> fetchPosts();
}
