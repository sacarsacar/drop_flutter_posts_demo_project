part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPosts extends PostsEvent {
  final bool useShimmer;
  const FetchPosts({this.useShimmer = true});

  @override
  List<Object?> get props => [useShimmer];
}

//  for like post event:
class LikePost extends PostsEvent {
  final int postId;
  const LikePost(this.postId);

  @override
  List<Object> get props => [postId];
}
