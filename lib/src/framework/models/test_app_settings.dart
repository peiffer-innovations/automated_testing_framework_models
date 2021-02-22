import 'package:meta/meta.dart';

/// Provides settings for the test app that apply globaly.  Any settings set
/// here will globally override values from other parts of the framework.
@immutable
class TestAppSettings {
  const TestAppSettings._({
    this.appIdentifier,
    this.deviceGroup,
    this.deviceId,
    this.stepTimeout,
    this.testTimeout,
  });

  static TestAppSettings _settings = TestAppSettings._();

  /// The unique identifier for the application.  This can be anything
  /// meaningful for the application.  It can be the application's name, the
  /// bundle id, etc.
  final String appIdentifier;

  /// Group name / identifier for a group of test devices.  If not set, the
  /// device will be treated as a standalone device.
  final String deviceGroup;

  /// Override for the device id.  This can be set by the application to provide
  /// stable ids for the test device framework.  If not set, the id from the
  /// [device_info] plugin will be used.
  final String deviceId;

  /// Sets the default timeout to apply to each test step.
  final Duration stepTimeout;

  /// Sets the default timeout to apply to each test.
  final Duration testTimeout;

  static TestAppSettings get settings => _settings ?? TestAppSettings._();

  static void initialize({
    String appIdentifier,
    String deviceGroup,
    String deviceId,
    Duration stepTimeout,
    Duration testTimeout,
  }) =>
      _settings = TestAppSettings._(
        appIdentifier: appIdentifier,
        deviceGroup: deviceGroup,
        deviceId: deviceId,
        stepTimeout: stepTimeout,
        testTimeout: testTimeout,
      );
}
