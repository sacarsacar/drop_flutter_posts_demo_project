import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  static String baseUrl = dotenv.env['BASE_URL'] ?? '';
}
