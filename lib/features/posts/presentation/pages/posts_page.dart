import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_demo_project/core/bloc/theme_bloc.dart';
import 'package:posts_demo_project/core/constants/strings.dart';
import 'package:posts_demo_project/core/injection/injection.dart';
import 'package:posts_demo_project/core/theme.dart';
import 'package:posts_demo_project/core/utils/snackbar.dart';
import 'package:posts_demo_project/features/posts/data/models/posts_model.dart';
import 'package:posts_demo_project/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:posts_demo_project/features/posts/presentation/widgets/post_card_widget.dart';
import 'package:posts_demo_project/core/utils/responsive_query.dart';
import 'package:posts_demo_project/features/posts/presentation/widgets/shimmer_widget.dart';
import 'package:posts_demo_project/core/utils/loader.dart';
import 'package:posts_demo_project/core/utils/scroll_controller_provider.dart';
import 'dart:math' as math;

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Widget _shimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 7,
      itemBuilder: (context, index) => const ShimmerPostCard(),
    );
  }

  // scroll logic is provided by ScrollControllerProvider

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocProvider(
          create: (_) => getIt<PostsBloc>()..add(const FetchPosts()),
          child: ScrollControllerProvider(
            builder: (context, controller, progressListenable, showListenable, scrollToTop) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(postPageTitle),
                  actions: [
                    // favorites badge :
                    BlocSelector<PostsBloc, PostsState, int>(
                      selector: (state) =>
                          state is PostsLoaded ? state.likedIds.length : 0,
                      builder: (context, favCount) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_outline),
                                onPressed: () {
                                  showAppSnackBar(
                                    context,
                                    'Favorites: $favCount',
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    backgroundColor: AppColors.blue,
                                    behavior: SnackBarBehavior.floating,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 10,
                                    ),
                                  );
                                },
                              ),
                              if (favCount > 0)
                                Positioned(
                                  right: 6,
                                  top: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 20,
                                      minHeight: 18,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$favCount',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        themeState.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                      onPressed: () {
                        context.read<ThemeBloc>().add(const ToggleThemeEvent());
                      },
                    ),
                  ],
                ),

                // scroll to top button
                floatingActionButton: ValueListenableBuilder<bool>(
                  valueListenable: showListenable,
                  builder: (_, show, _) {
                    return show
                        ? FloatingActionButton(
                            onPressed: scrollToTop,
                            child: const Icon(Icons.arrow_upward),
                          )
                        : const SizedBox.shrink();
                  },
                ),

                body: BlocBuilder<PostsBloc, PostsState>(
                  builder: (context, state) {
                    // loading state: show shimmer + centered loader
                    if (state is PostsLoading) {
                      return Stack(
                        children: [
                          _shimmerList(),
                          Positioned.fill(
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor
                                  // ignore: deprecated_member_use
                                  .withOpacity(0.6),
                              child: const Center(child: Loader()),
                            ),
                          ),
                        ],
                      );
                    }

                    // post loaded state:
                    if (state is PostsLoaded) {
                      final List<Post> posts = state.posts;

                      // if refreshing: show shimmer + loader overlay to indicate refresh
                      if (state.isRefreshing) {
                        return Stack(
                          children: [
                            _shimmerList(),
                            Positioned.fill(
                              child: Container(
                                color: Theme.of(context).scaffoldBackgroundColor
                                    // ignore: deprecated_member_use
                                    .withOpacity(0.6),
                                child: const Center(child: Loader()),
                              ),
                            ),
                          ],
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          final bloc = context.read<PostsBloc>();
                          bloc.add(const FetchPosts(useShimmer: false));
                          // keeping the refresh indicator visible until loading completes
                          await bloc.stream.firstWhere(
                            (s) => s is PostsLoaded || s is PostsError,
                          );
                        },
                        child: Center(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              // responsive grid: 2 columns on desktop, 1 on mobile/tablet
                              return Builder(
                                builder: (context) {
                                  final screen = ScreenHelper(context);

                                  // cap grid max width on very large desktop monitors
                                  final maxAllowedWidth = screen.isDesktop
                                      ? 1000.0
                                      : screen.maxWidth;
                                  final availableWidth = math.min(
                                    constraints.maxWidth,
                                    maxAllowedWidth,
                                  );

                                  final columns = screen.isDesktop ? 2 : 1;
                                  const spacing = 12.0;
                                  final cardWidth =
                                      (availableWidth -
                                          spacing * (columns + 1)) /
                                      columns;

                                  final cardHeight = screen.isDesktop
                                      ? 175.0
                                      : screen.isTablet
                                      ? 180.0
                                      : 165.sp;

                                  final childAspectRatio =
                                      cardWidth / cardHeight;

                                  return Align(
                                    alignment: Alignment.topCenter,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: availableWidth,
                                      ),
                                      child: Column(
                                        children: [
                                          // thin progress bar showing scroll position
                                          SizedBox(
                                            height: 4,
                                            child:
                                                ValueListenableBuilder<double>(
                                                  valueListenable:
                                                      progressListenable,
                                                  builder: (_, value, _) =>
                                                      LinearProgressIndicator(
                                                        value: value,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      ),
                                                ),
                                          ),
                                          // grid with Scrollbar
                                          Expanded(
                                            child: Scrollbar(
                                              controller: controller,
                                              thumbVisibility: true,
                                              child: GridView.builder(
                                                controller: controller,
                                                padding: const EdgeInsets.all(
                                                  spacing,
                                                ),
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: columns,
                                                      crossAxisSpacing: spacing,
                                                      mainAxisSpacing: spacing,
                                                      childAspectRatio:
                                                          childAspectRatio,
                                                    ),
                                                cacheExtent:
                                                    1000, // prefetch + smoother scroll
                                                itemCount: posts.length,
                                                itemBuilder: (context, index) {
                                                  final post = posts[index];
                                                  return RepaintBoundary(
                                                    // reduce repaints
                                                    child: PostCard(
                                                      title: post.title,
                                                      body: post.body,
                                                      username: postUsername,
                                                      imageUrl:
                                                          'https://picsum.photos/id/${post.id}/200/200',
                                                      liked: state.likedIds
                                                          .contains(post.id),
                                                      onLikeToggle: () {
                                                        context
                                                            .read<PostsBloc>()
                                                            .add(
                                                              LikePost(post.id),
                                                            );
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    }

                    // error state:
                    if (state is PostsError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: AppColors.red),
                        ),
                      );
                    }

                    // initial state:
                    return const Center(child: Text(postInitialMessage));
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
