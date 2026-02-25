import 'package:intime_manager/network/socket/socket_client.dart';

abstract class BaseSocketService {
  Future<T> execute<T>(Future<T> Function(SocketClient client) operation) async {
    final client = SocketClient();
    try {
      await client.connect();
      final result = await operation(client);
      return result;
    } catch (e) {
      rethrow;
    } finally {
      await client.disconnect();
    }
  }

  Future<void> executeVoid(Future<void> Function(SocketClient client) operation) async {
    final client = SocketClient();
    try {
      await client.connect();
      await operation(client);
    } catch (e) {
      rethrow;
    } finally {
      await client.disconnect();
    }
  }
}
