import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:posts_demo_project/core/injection/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
