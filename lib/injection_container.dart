import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:posts_demo_project/core/bloc/theme_bloc.dart';
import 'package:posts_demo_project/core/constants/api_routes.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Dio client:
  getIt.registerLazySingleton(
    () => Dio(BaseOptions(baseUrl: ApiRoutes.baseUrl)),
  );

  // theme bloc:
  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
}
