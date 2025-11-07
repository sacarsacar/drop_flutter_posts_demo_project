import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_demo_project/core/bloc/theme_bloc.dart';
import 'package:posts_demo_project/core/theme.dart';
import 'package:posts_demo_project/core/routes/routes.dart';
import 'flavors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              title: F.title,
              theme: AppTheme.lightTheme(context),
              darkTheme: AppTheme.darkTheme(context),
              themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            );
          },
        );
      },
    );
  }
}
