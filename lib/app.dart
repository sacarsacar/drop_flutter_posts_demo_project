import 'package:flutter/material.dart';
import 'package:posts_demo_project/core/theme.dart';
import 'package:posts_demo_project/core/routes/routes.dart';
import 'flavors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: F.title,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      themeMode: ThemeMode.system,
    );
  }
}
