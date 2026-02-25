import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkConfig {
  static String get serverHost {
    return dotenv.env['SERVER_HOST'] ?? dotenv.env['SOCKET_SERVER_URL'] ?? '';
  }

  static int get serverPort {
    final portStr = dotenv.env['SERVER_PORT'] ?? dotenv.env['PORT'] ?? '4795';
    return int.tryParse(portStr) ?? 4795;
  }
}
