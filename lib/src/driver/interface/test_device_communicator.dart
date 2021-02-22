import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';

/// Interface that plugins may implement to provide their own solution for
/// communicating with external sources.
abstract class TestDeviceCommunicator {
  /// Returns whether or not the communicator is currently active
  bool get active;

  /// Returns the stream that will fire whenever the communicator receives a
  /// command from the external driver.  This may return [null] if the
  /// communicator is not currently active.
  Stream<DeviceCommand> get commandStream;

  /// Returns whether the communicator is currently connected to the external
  /// source or not.  This may be [false] because the communicator is
  /// not connected, but still trying to connect.  To determine if the
  /// communicator is trying to connect, use the [active] property.
  bool get connected;

  /// Sets the function that will be called whenever the
  set onConnectionChanged(ConnectionChangedCallback callback);

  /// Instructs the driver to connect to the external source.  By the time the
  /// returned [Future] completes, the [commandStream] must be available to be
  /// listened to.
  Future<void> activate(
      Future<TestDeviceInfo> Function() testDeviceInfoBuilder);

  /// Instructs the driver to deactivate and disconnect from any external
  /// source.
  Future<void> deactivate();

  /// This will send the comamnd to the external source.  If the communicator
  /// is not [active], this will throw an exception.  If the communicator is
  /// offline, but active, it should send the command the next time it
  /// reconnects.
  Future<void> sendCommand(DeviceCommand command);
}
