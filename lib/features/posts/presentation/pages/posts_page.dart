import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_demo_project/core/bloc/theme_bloc.dart';
import 'package:posts_demo_project/core/injection/injection.dart';
import 'package:posts_demo_project/core/utils/loader.dart';
import 'package:posts_demo_project/features/posts/data/models/posts_model.dart';
import 'package:posts_demo_project/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:posts_demo_project/features/posts/presentation/widgets/post_card_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocProvider(
          create: (_) => getIt<PostsBloc>()..add(FetchPosts()),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Posts'),
              actions: [
                IconButton(
                  icon: Icon(
                    themeState.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  ),
                  onPressed: () {
                    context.read<ThemeBloc>().add(const ToggleThemeEvent());
                  },
                ),
              ],
            ),

            body: BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                // loading state:
                if (state is PostsLoading) {
                  return const Center(child: Loader());
                }
                // post loaded state:
                if (state is PostsLoaded) {
                  final List<Post> posts = state.posts;

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<PostsBloc>().add(FetchPosts());
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return PostCard(
                          title: post.title,
                          body: post.body,
                          username: "Sakar Chaulagain",
                          imageUrl:
                              'https://picsum.photos/id/${post.id}/200/200',
                          liked: false,
                          onLikeToggle: () {},
                        );
                      },
                    ),
                  );
                }

                // error state:
                if (state is PostsError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                // initial state:
                return const Center(child: Text('No posts yet'));
              },
            ),
          ),
        );
      },
    );
  }
}
