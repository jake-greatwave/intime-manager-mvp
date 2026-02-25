import 'package:intime_manager/network/socket/socket_client.dart';

abstract class BaseSocketService {
  final SocketClient _socketClient = SocketClient();

  Future<T> execute<T>(Future<T> Function(SocketClient client) operation) async {
    try {
      await _socketClient.connect();
      final result = await operation(_socketClient);
      return result;
    } catch (e) {
      rethrow;
    } finally {
      await _socketClient.disconnect();
    }
  }

  Future<void> executeVoid(Future<void> Function(SocketClient client) operation) async {
    try {
      await _socketClient.connect();
      await operation(_socketClient);
    } catch (e) {
      rethrow;
    } finally {
      await _socketClient.disconnect();
    }
  }
}
