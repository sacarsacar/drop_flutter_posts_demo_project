# posts_demo_project

A new Flutter project.

## Getting Started

Dot Env: : BaseUrl=https://jsonplaceholder.typicode.com/posts

# For Android/iOS with different flavors:

flutter run --flavor dev # Development flavor
flutter run --flavor staging # Staging flavor
flutter run --flavor prod # Production flavor

inside .vscode create a file launch.json and paste this :
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



build runner command : flutter pub run build_runner watch --delete-conflicting-outputs
