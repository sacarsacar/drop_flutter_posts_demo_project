import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:posts_demo_project/core/constants/api_routes.dart';
import 'package:posts_demo_project/features/posts/data/models/posts_model.dart';
import 'package:posts_demo_project/features/posts/domain/posts_repositories.dart';

@LazySingleton(as: PostsRepositories)
class PostRepositoriesImpl implements PostsRepositories {
  final Dio dio;

  PostRepositoriesImpl(this.dio);

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await dio.get(ApiRoutes.baseUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => Post.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
