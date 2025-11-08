import 'package:posts_demo_project/core/theme.dart';
import 'package:posts_demo_project/core/utils/responsive_query.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPostCard extends StatelessWidget {
  const ShimmerPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase(context),
      highlightColor: AppColors.shimmerHighlight(context),
      period: Duration(milliseconds: 1500),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screen = ScreenHelper(context);
          return Card(
            color: AppColors.transparent,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // image placeholder
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: AppColors.shimmerBase(context),
                  ),
                ),

                // content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title line 1
                        Container(
                          height: 16,
                          width: double.infinity,
                          color: AppColors.shimmerBase(context),
                        ),
                        const SizedBox(height: 6),
                        // title line 2
                        Container(
                          height: 14,
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: AppColors.shimmerBase(
                            context,
                            // ignore: deprecated_member_use
                          ).withOpacity(0.9),
                        ),
                        const SizedBox(height: 10),
                        // body line 1
                        Container(
                          height: 12,
                          width: double.infinity,
                          color: AppColors.shimmerBase(context),
                        ),
                        const SizedBox(height: 6),
                        // body line 2
                        Container(
                          height: 12,
                          width: MediaQuery.of(context).size.width * 0.4,
                          color: AppColors.shimmerBase(context),
                        ),
                        SizedBox(height: screen.spacing.toDouble() - 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // avatar
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: AppColors.shimmerBase(
                                    context,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                // username
                                Container(
                                  height: 12,
                                  width: 90,
                                  color: AppColors.shimmerBase(context),
                                ),
                              ],
                            ),
                            // like button
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.shimmerBase(context),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
