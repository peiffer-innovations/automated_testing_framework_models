import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';

@immutable
class GoldenTestImages extends JsonClass {
  GoldenTestImages({
    required this.deviceInfo,
    this.goldenHashes,
    String? id,
    this.suiteName,
    required this.testName,
    required this.testVersion,
    DateTime? timestamp,
  })  : id = id ??
            createId(
              deviceInfo: deviceInfo,
              suiteName: suiteName,
              testName: testName,
            ),
        timestamp = timestamp ?? DateTime.now();

  final TestDeviceInfo deviceInfo;
  final Map<String, String>? goldenHashes;
  final String id;
  final String? suiteName;
  final String testName;
  final int testVersion;
  final DateTime timestamp;

  static String createId({
    required TestDeviceInfo deviceInfo,
    String? suiteName,
    required String testName,
  }) {
    final suitePrefix = suiteName?.isNotEmpty == true ? '${suiteName}_' : '';
    return '${suitePrefix}${testName}_${deviceInfo.appIdentifier}_${deviceInfo.os}_${deviceInfo.systemVersion}_${deviceInfo.model}_${deviceInfo.device}_${deviceInfo.orientation}_${deviceInfo.pixels?.height}_${deviceInfo.pixels?.width}';
  }

  static String createIdFromReport(TestReport report) {
    final suiteName = report.suiteName;
    final testName = report.name;
    final deviceInfo = report.deviceInfo;

    return createId(
      deviceInfo: deviceInfo ?? TestDeviceInfo.unknown(),
      suiteName: suiteName,
      testName: testName ?? 'unknown',
    );
  }

  static GoldenTestImages? fromDynamic(dynamic map) {
    GoldenTestImages? result;

    if (map != null) {
      result = GoldenTestImages(
        deviceInfo: TestDeviceInfo.fromDynamic(map['deviceInfo']),
        goldenHashes: map['goldenHashes'] == null
            ? null
            : Map<String, String>.from(map['goldenHashes']),
        id: map['id'],
        suiteName: map['suiteName'],
        testName: map['testName'],
        testVersion: JsonClass.parseInt(map['testVersion']) ?? 0,
        timestamp: JsonClass.parseUtcMillis(map['timestamp']),
      );
    }

    return result;
  }

  static GoldenTestImages fromTestReport(TestReport report) {
    final goldenHashes = <String, String>{};

    for (var image in report.images) {
      if (image.goldenCompatible == true) {
        goldenHashes[image.id] = image.hash;
      }
    }

    return GoldenTestImages(
      deviceInfo: report.deviceInfo ?? TestDeviceInfo.unknown(),
      goldenHashes: goldenHashes,
      suiteName: report.suiteName,
      testName: report.name ?? 'unknown',
      testVersion: report.version,
      timestamp: DateTime.now(),
    );
  }

  @override
  bool operator ==(dynamic other) =>
      other is GoldenTestImages && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  Map<String, dynamic> toJson() => {
        'deviceInfo': deviceInfo.toJson(),
        'goldenHashes': goldenHashes,
        'id': id,
        'suiteName': suiteName,
        'testName': testName,
        'testVersion': testVersion,
        'timestamp': timestamp.millisecondsSinceEpoch,
      };
}
