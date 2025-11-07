import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:posts_demo_project/features/posts/data/models/posts_model.dart';

part 'post_api_client.g.dart';

@RestApi()
abstract class PostApiClient {
  factory PostApiClient(Dio dio, {String? baseUrl}) = _PostApiClient;
  @GET('/')
  Future<List<Post>> fetchPosts();
}
