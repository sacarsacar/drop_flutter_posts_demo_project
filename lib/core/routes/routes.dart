import 'package:go_router/go_router.dart';
import 'package:posts_demo_project/features/splash/presentation/pages/splash_screen.dart';
import 'package:posts_demo_project/features/posts/presentation/pages/posts_page.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/', builder: (_, _) => const PostScreen()),
    GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
  ],
);
