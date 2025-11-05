import 'package:posts_demo_project/core/constants/strings.dart';

enum Flavor { dev, staging, prod }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return appNameDev;
      case Flavor.staging:
        return appNameStaging;
      case Flavor.prod:
        return appNameProd;
    }
  }
}
