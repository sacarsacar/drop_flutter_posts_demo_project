import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posts_demo_project/core/injection/injection.dart';

import 'app.dart';
import 'core/bloc/theme_bloc.dart';
import 'flavors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initializing Hive Flutter and open likes box
  await Hive.initFlutter();
  await Hive.openBox<bool>('likes');

  // Initialize HydratedBloc storage
  if (kIsWeb) {
    //  setting up HydratedBloc for web:
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(''),
    );
  } else {
    final directory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(directory.path),
    );
  }

  // Configuring dependency injection
  await configureDependencies();

  // setting up the flavor :
  const String flavorName = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == flavorName,
    orElse: () => Flavor.dev,
  );

  debugPrint('🚀 Running in ${F.name} mode');

  runApp(BlocProvider(create: (_) => ThemeBloc(), child: const MyApp()));
}
