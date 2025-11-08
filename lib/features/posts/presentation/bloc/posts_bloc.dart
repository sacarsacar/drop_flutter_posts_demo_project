import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_demo_project/features/posts/data/models/posts_model.dart';
import 'package:posts_demo_project/features/posts/domain/posts_repositories.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'posts_event.dart';
part 'posts_state.dart';

@injectable
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepositories _repository;
  static const String _likesBox = 'likes';

  PostsBloc(this._repository) : super(PostsInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<LikePost>(_onLikePost);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    final current = state;

    if (event.useShimmer) {
      emit(PostsLoading());
    } else if (current is PostsLoaded) {
      emit(PostsLoaded(current.posts, current.likedIds, true));
    } else {
      emit(PostsLoading());
    }

    try {
      //  simulating network delay to show shimmer effect properly
      await Future.delayed(const Duration(milliseconds: 800));

      final posts = await _repository.fetchPosts();

      // Load likes from Hive box:
      final box = Hive.isBoxOpen(_likesBox) ? Hive.box<bool>(_likesBox) : null;
      final likedPosts = <int>{};
      if (box != null) {
        for (final key in box.keys) {
          final value = box.get(key);
          if (value == true) {
            final id = int.tryParse(key.toString());
            if (id != null) likedPosts.add(id);
          }
        }
      }
      emit(PostsLoaded(posts, likedPosts, false));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  //  like post handler:
  Future<void> _onLikePost(LikePost event, Emitter<PostsState> emit) async {
    final current = state;
    if (current is! PostsLoaded) return;

    final box = Hive.isBoxOpen(_likesBox) ? Hive.box<bool>(_likesBox) : null;
    final key = event.postId.toString();
    final prev = box?.get(key, defaultValue: false) ?? false;
    final next = !prev;
    if (box != null) await box.put(key, next);

    final updated = Set<int>.from(current.likedIds);
    if (next) {
      updated.add(event.postId);
    } else {
      updated.remove(event.postId);
    }

    emit(PostsLoaded(current.posts, updated, current.isRefreshing));
  }
}
