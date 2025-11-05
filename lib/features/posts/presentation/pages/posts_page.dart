import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_demo_project/core/bloc/theme_bloc.dart';
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
        return Scaffold(
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
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              PostCard(
                title: "Hello",
                body:
                    "What on Earth Bro . why are you gay? are you fucking crazy..",
                username: "Sakar Chaulagain",
                imageUrl: 'https://picsum.photos/200',
                liked: false,
                onLikeToggle: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
