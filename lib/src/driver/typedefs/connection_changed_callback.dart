import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';

typedef ConnectionChangedCallback = Future<void> Function(
  TestDeviceCommunicator communicator,
  bool connected,
);
