part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;
  final Set<int> likedIds;
  final bool isRefreshing;

  const PostsLoaded(
    this.posts, [
    this.likedIds = const {},
    this.isRefreshing = false,
  ]);

  @override
  List<Object?> get props => [posts, likedIds, isRefreshing];
}

class PostsError extends PostsState {
  final String message;

  const PostsError(this.message);

  @override
  List<Object?> get props => [message];
}
