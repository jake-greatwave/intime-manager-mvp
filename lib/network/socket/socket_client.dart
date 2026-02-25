import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:intime_manager/network/config/network_config.dart';

class SocketClient {
  Socket? _socket;
  bool _isConnected = false;
  StreamController<String>? _responseController;
  StreamSubscription<List<int>>? _subscription;

  bool get isConnected => _isConnected;

  StreamController<String> get _getOrCreateController {
    if (_responseController == null || _responseController!.isClosed) {
      _responseController = StreamController<String>.broadcast();
    }
    return _responseController!;
  }

  Future<void> connect() async {
    if (_isConnected) {
      return;
    }

    try {
      _socket = await Socket.connect(
        NetworkConfig.serverHost,
        NetworkConfig.serverPort,
      );
      _isConnected = true;

      _subscription = _socket!.listen(
        (List<int> data) {
          String message;
          try {
            message = utf8.decode(data, allowMalformed: false);
          } catch (e) {
            message = latin1.decode(data);
          }
          _getOrCreateController.add(message);
        },
        onError: (error) {
          _getOrCreateController.addError(error);
        },
        onDone: () {
          _isConnected = false;
        },
        cancelOnError: false,
      );
    } catch (e) {
      _isConnected = false;
      rethrow;
    }
  }

  void send(String message) {
    if (!_isConnected || _socket == null) {
      throw Exception('Socket is not connected');
    }
    _socket!.write(message);
  }

  Stream<String> get stream => _getOrCreateController.stream;

  Future<void> disconnect() async {
    await _subscription?.cancel();
    _subscription = null;
    await _socket?.close();
    _socket = null;
    _isConnected = false;
    if (_responseController != null && !_responseController!.isClosed) {
      await _responseController!.close();
    }
    _responseController = null;
  }
}
