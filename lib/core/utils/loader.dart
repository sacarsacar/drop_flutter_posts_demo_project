import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:posts_demo_project/core/theme.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80,
        width: 80,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [AppColors.red, AppColors.blue, AppColors.green],
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
