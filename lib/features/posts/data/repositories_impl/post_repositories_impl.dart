import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:posts_demo_project/core/constants/api_routes.dart';
import 'package:posts_demo_project/features/posts/data/models/posts_model.dart';
import 'package:posts_demo_project/features/posts/domain/posts_repositories.dart';
import 'package:posts_demo_project/features/posts/data/datasources/post_api_client.dart';

@LazySingleton(as: PostsRepositories)
class PostRepositoriesImpl implements PostsRepositories {
  final PostApiClient client;

  PostRepositoriesImpl(this.client);

  @override
  Future<List<Post>> fetchPosts() async {
    final base = ApiRoutes.baseUrl;
    if (base.isEmpty) {
      throw Exception('BASE_URL is empty.');
    }

    try {
      // Using generated Retrofit client
      final posts = await client.fetchPosts();
      return posts;
    } on DioException catch (dioErr) {
      throw Exception(
        'Failed to load posts: ${dioErr.response?.statusCode ?? ''} ${dioErr.message}',
      );
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
