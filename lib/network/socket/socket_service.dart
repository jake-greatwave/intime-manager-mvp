import 'dart:async';
import 'dart:convert';
import 'package:intime_manager/network/socket/base_socket_service.dart';
import 'package:intime_manager/models/request/socket_request.dart';

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);

  @override
  String toString() => message;
}

class SocketService extends BaseSocketService {
  Future<Map<String, dynamic>> sendAndReceive({
    required SocketRequest request,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    return execute<Map<String, dynamic>>((client) async {
      final completer = Completer<Map<String, dynamic>>();
      final timer = Timer(timeout, () {
        if (!completer.isCompleted) {
          completer.completeError(
            TimeoutException('Socket request timed out after ${timeout.inSeconds} seconds'),
          );
        }
      });

      final subscription = client.stream.listen(
        (message) {
          if (!completer.isCompleted) {
            try {
              final response = jsonDecode(message);
              timer.cancel();
              completer.complete(response as Map<String, dynamic>);
            } catch (e) {
              timer.cancel();
              completer.completeError(Exception('Failed to parse response: $e'));
            }
          }
        },
        onError: (error) {
          if (!completer.isCompleted) {
            timer.cancel();
            completer.completeError(error);
          }
        },
      );

      final requestJson = jsonEncode(request.toJson());
      client.send('$requestJson\n');

      try {
        final result = await completer.future;
        await subscription.cancel();
        return result;
      } catch (e) {
        await subscription.cancel();
        rethrow;
      }
    });
  }

  Future<void> send({
    required SocketRequest request,
  }) async {
    await executeVoid((client) async {
      final requestJson = jsonEncode(request.toJson());
      client.send('$requestJson\n');
    });
  }
}
