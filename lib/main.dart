import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/bloc/theme_bloc.dart';
import 'flavors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize HydratedBloc storage
  final directory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(directory.path),
  );

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
