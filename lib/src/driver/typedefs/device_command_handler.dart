import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';

typedef DeviceCommandHandler = Future<CommandAck> Function(
  DeviceCommand command,
);
