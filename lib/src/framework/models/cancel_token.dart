import 'dart:async';

import 'package:logging/logging.dart';

/// Token can can be used to cancel test steps.
class CancelToken {
  CancelToken({
    this.timeout,
  }) {
    if (timeout != null) {
      _timer = Timer(timeout, () => cancel());
    }
  }

  static final Logger _logger = Logger('CancelToken');

  final Duration timeout;

  StreamController<void> _controller = StreamController<bool>.broadcast();

  bool _cancelled = false;
  bool _completed = false;
  Timer _timer;

  bool get cancelled => _cancelled;
  bool get completed => _completed;
  Stream<void> get stream => _controller?.stream;

  Future<void> cancel() async {
    if (_controller != null) {
      _logger.info('[CANCEL_TOKEN]: cancelling the token.');
      _timer?.cancel();
      _timer = null;

      _cancelled = true;
      _controller.add(null);
      await _controller?.close();
      _controller = null;
    }
  }

  Future<void> complete() async {
    if (_controller != null) {
      _timer?.cancel();
      _timer = null;

      _completed = true;
      await _controller?.close();
      _controller = null;
    }
  }
}
