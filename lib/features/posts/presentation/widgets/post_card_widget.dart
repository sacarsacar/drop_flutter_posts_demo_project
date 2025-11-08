import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_demo_project/core/theme.dart';
import 'package:posts_demo_project/core/utils/responsive_query.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String body;
  final String username;
  final String imageUrl;
  final bool liked;
  final VoidCallback onLikeToggle;

  const PostCard({
    super.key,
    required this.title,
    required this.body,
    required this.username,
    required this.imageUrl,
    required this.liked,
    required this.onLikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screen = ScreenHelper(context);

        // Using the provided maxHeight when available
        final tileHeight = (constraints.maxHeight > 0)
            ? constraints.maxHeight
            : 200.0;

        // setting image height to tile height
        final imageHeight = tileHeight;

        return Card(
          elevation: 1,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // image section:
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                  ),
                  child: SizedBox(
                    width: screen.postcardimageWidth,
                    height: imageHeight,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: screen.postcardimageWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        width: screen.postcardimageWidth,
                        height: imageHeight,
                        color: AppColors.greymedium,
                        child: Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                  ),
                ),

                // text section:
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(screen.paddingAllEdgeInsets),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Title
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: screen.spacing.toDouble() - 10),

                        Text(
                          body,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[700]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const Spacer(),

                        // Footer row (avatar + username + like)
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12.r,
                                    backgroundColor: AppColors.greymedium,
                                    child: Text(
                                      username.isNotEmpty
                                          ? username[0].toUpperCase()
                                          : '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      username,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              iconSize: 20,
                              padding: EdgeInsets.all(
                                screen.paddingAllEdgeInsets,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                              icon: Icon(
                                liked ? Icons.favorite : Icons.favorite_border,
                                color: liked
                                    ? AppColors.red
                                    : Theme.of(context).iconTheme.color,
                              ),
                              onPressed: onLikeToggle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
