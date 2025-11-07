import 'package:posts_demo_project/core/utils/responsive_query.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPostCard extends StatelessWidget {
  const ShimmerPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screen = ScreenHelper(context);
          return Card(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
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
                    color: isDark ? Colors.grey[700] : Colors.grey[300],
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
                          color: isDark ? Colors.grey[700] : Colors.grey[300],
                        ),
                        const SizedBox(height: 6),
                        // title line 2
                        Container(
                          height: 14,
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: isDark ? Colors.grey[700] : Colors.grey[300],
                        ),
                        const SizedBox(height: 10),
                        // body line 1
                        Container(
                          height: 12,
                          width: double.infinity,
                          color: isDark ? Colors.grey[700] : Colors.grey[300],
                        ),
                        const SizedBox(height: 6),
                        // body line 2
                        Container(
                          height: 12,
                          width: MediaQuery.of(context).size.width * 0.4,
                          color: isDark ? Colors.grey[700] : Colors.grey[300],
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
                                  backgroundColor: isDark
                                      ? Colors.grey[700]
                                      : Colors.grey[300],
                                ),
                                const SizedBox(width: 6),
                                // username
                                Container(
                                  height: 12,
                                  width: 90,
                                  color: isDark
                                      ? Colors.grey[700]
                                      : Colors.grey[300],
                                ),
                              ],
                            ),
                            // like button
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.grey[700]
                                    : Colors.grey[300],
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
