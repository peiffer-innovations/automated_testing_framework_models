import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:meta/meta.dart';

@immutable
class TestReportMetadata {
  TestReportMetadata({
    @required this.deviceInfo,
    @required this.id,
    @required this.numSteps,
    @required this.passedSteps,
    @required this.success,
    @required this.suiteName,
    @required this.testName,
    @required this.testVersion,
    @required this.timestamp,
  })  : assert(testName?.isNotEmpty == true),
        assert(timestamp != null);

  final TestDeviceInfo deviceInfo;
  final String id;
  final int numSteps;
  final int passedSteps;
  final bool success;
  final String suiteName;
  final String testName;
  final int testVersion;
  final DateTime timestamp;

  static TestReportMetadata fromTestReport(TestReport report) {
    TestReportMetadata result;

    if (report != null) {
      result = TestReportMetadata(
        deviceInfo: report.deviceInfo,
        id: report.id,
        numSteps: report.steps.length,
        passedSteps: report.passedSteps,
        success: report.success ?? false,
        suiteName: report.suiteName,
        testName: report.name,
        testVersion: report.version,
        timestamp: report.endTime,
      );
    }

    return result;
  }
}
