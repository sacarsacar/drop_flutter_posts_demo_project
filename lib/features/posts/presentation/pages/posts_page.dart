import 'package:flutter/material.dart';
import 'package:posts_demo_project/features/posts/presentation/widgets/post_card_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts', style: TextStyle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              // Implement refresh functionality here
            },
          ),
        ],
      ),
      body: Column(
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
  }
}
