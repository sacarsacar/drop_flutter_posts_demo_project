# posts_demo_project

Author: Sakar Chaulagain — https://github.com/sacarsacar

A lightweight Flutter demo for browsing posts — view, read, and favorite posts with a clean, responsive Material 3 UI.

## Overview

This demo app focuses on posts: browsing, reading, and locally favoriting them. It includes pull-to-refresh, loading & error states, shimmer placeholders, responsive Material 3 design, light/dark themes, and local favorite counts.

## Features

- Pull-to-refresh for post lists
- Loading & error states with shimmer placeholders
- Clean, responsive Material 3 UI (using flutter_screenutil)
- Favorite toggle per post (local state only)
- Favorite counts (local)
- Dark and light modes

## Used packages (and purpose)

- flutter — SDK
- cupertino_icons — iOS-style icons
- dio — HTTP client
- retrofit (+ retrofit_generator) — Retrofit-like API layer for Dio
- flutter_dotenv — Load environment variables from .env
- json_annotation / json_serializable — JSON model annotations and codegen
- bloc / flutter_bloc — State management
- hydrated_bloc — Persist BLoC state locally
- path_provider — Filesystem paths (hydrated storage)
- equatable — Value equality for models/blocs
- google_fonts — Custom fonts
- go_router — Declarative routing
- flutter_screenutil — Responsive sizing utilities
- shimmer — Shimmer loading placeholders
- cached_network_image — Image caching & placeholders
- get_it / injectable / injectable_generator — Dependency injection + codegen
- loading_indicator — Prebuilt loading animations
- hive / hive_flutter — Lightweight local storage (e.g., favorites)

Dev / codegen:

- build_runner — Run code generation
- json_serializable — Generate model serialization code
- retrofit_generator — Generate Retrofit clients
- injectable_generator — Generate DI bootstrapping
- flutter_flavorizr — Flavor management
- flutter_lints — Lint rules
- flutter_test — Test framework

## Folder structure (lib/)

- lib/
  - core/
    - bloc/ — global/common BLoCs (theme, app-level)
    - constants/ — app constants and keys
    - injection/ — get_it + injectable setup (generated files)
    - routes/ — go_router route definitions
    - utils/ — helpers & extensions
  - features/
    - posts/
      - data/
        - datasource/ — API / local data sources
        - models/ — JSON models & generated code
        - repositories_impl/ — concrete repository implementations
      - domain/
        - repositories/ — repository interfaces
      - presentation/
        - bloc/ — feature BLoCs
        - pages/ — screens (list, detail)
        - widgets/ — reusable widgets
    - splash/
      - presentation/
        - pages/ — splash/loading screen

## Getting started

1. Create a `.env` file in the project root with at least:
   BaseUrl=https://api.example.com

2. Install packages:
   flutter pub get

3. Run code generation (watch recommended during development):
   flutter pub run build_runner watch --delete-conflicting-outputs
   or one-shot:
   flutter pub run build_runner build --delete-conflicting-outputs

4. Run the app with flavors:
   flutter run --flavor dev
   flutter run --flavor staging
   flutter run --flavor prod

### VS Code launch configuration

Create a `.vscode/launch.json` file with the following to run flavors from VS Code:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Dev",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--flavor", "dev", "--dart-define=FLAVOR=dev"]
    },
    {
      "name": "Staging",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--flavor", "staging", "--dart-define=FLAVOR=staging"]
    },
    {
      "name": "Prod",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--flavor", "prod", "--dart-define=FLAVOR=prod"]
    }
  ]
}
```

## Notes

- Favorites are stored locally (HydratedBloc / Hive) and do not sync to a backend.
- Dependency injection is implemented with get_it + injectable (codegen).
- Use flutter_screenutil & MediaQuery for responsive layouts and Material 3 theming for consistent UI.

![Flutter CI/CD](https://github.com/sacarsacar/drop_flutter_posts_demo_project/actions/workflows/flutter_cicd.yml/badge.svg)
