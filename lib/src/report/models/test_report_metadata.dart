import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';

@immutable
class TestReportMetadata extends JsonClass {
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

  static TestReportMetadata fromDynamic(dynamic map) {
    TestReportMetadata result;

    if (map != null) {
      result = TestReportMetadata(
        deviceInfo: map['deviceInfo'],
        id: map['id'],
        numSteps: JsonClass.parseInt(map['numSteps']),
        passedSteps: JsonClass.parseInt(map['passedSteps']),
        success: JsonClass.parseBool(map['success']),
        suiteName: map['suiteName'],
        testName: map['testName'],
        testVersion: map['testVersion'],
        timestamp: JsonClass.parseUtcMillis(map['timestamp']),
      );
    }

    return result;
  }

  static TestReportMetadata fromTestReport(TestReport report) {
    TestReportMetadata result;

    if (report != null) {
      result = TestReportMetadata(
        deviceInfo: TestDeviceInfo.fromDynamic(report.deviceInfo),
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

  @override
  Map<String, dynamic> toJson() => {
        'deviceInfo': deviceInfo.toJson(),
        'id': id,
        'numSteps': numSteps,
        'passedSteps': passedSteps,
        'success': success,
        'suiteName': suiteName,
        'testName': testName,
        'testVersion': testVersion,
        'timestamp': timestamp.millisecondsSinceEpoch,
      };
}
