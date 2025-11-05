
import 'package:go_router/go_router.dart';
import 'package:posts_demo_project/features/posts/presentation/pages/posts_page.dart';

final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (_, _) => const PostScreen())],
);
