import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

enum InternetStatus { connected, disconnected }

/// Singleton service that emits internet connectivity status.
///
/// Usage:
/// ```dart
/// final conn = InternetConnection();
/// conn.initialize();
/// conn.onStatusChange.listen((status) { /* react */ });
/// // or check conn.isConnected
/// ```
class InternetConnection {
  InternetConnection._internal();
  static final InternetConnection _instance = InternetConnection._internal();
  factory InternetConnection() => _instance;

  final StreamController<InternetStatus> _controller =
      StreamController.broadcast();
  StreamSubscription<dynamic>? _connectivitySubscription;
  bool _isConnected = false;

  Stream<InternetStatus> get onStatusChange => _controller.stream;
  bool get isConnected => _isConnected;

  /// Start listening for connectivity changes and perform an active
  /// Internet check (DNS lookup) to determine real internet access.
  void initialize() {
    // Listen to connectivity type changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      _,
    ) {
      _checkConnection().then((connected) => _updateStatus(connected));
    });

    // perform an initial check
    _checkConnection().then((connected) => _updateStatus(connected));
  }

  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'example.com',
      ).timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _updateStatus(bool connected) {
    if (_isConnected != connected) {
      _isConnected = connected;
      _controller.add(
        connected ? InternetStatus.connected : InternetStatus.disconnected,
      );
    }
  }

  /// Stop listening and free resources.
  void dispose() {
    _connectivitySubscription?.cancel();
    _controller.close();
  }
}
