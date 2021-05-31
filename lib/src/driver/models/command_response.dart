import 'dart:convert';
import 'dart:typed_data';

import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:json_class/json_class.dart';
import 'package:logging/logging.dart';

/// Base class for the command responses associated to the [CommandAck].
class CommandResponse extends JsonClass {
  CommandResponse({
    this.message,
    this.payload,
    this.success,
    required this.type,
  }) : assert(message != null || payload != null);

  static final Map<String, CommandResponse Function(dynamic, String?, bool?)>
      _builders = {
    ListDevicesResponse.kResponseType: ListDevicesResponse.fromDynamic,
    LogResponse.kResponseType: LogResponse.fromDynamic,
    ScreenshotResponse.kResponseType: ScreenshotResponse.fromDynamic,
    TestStatusResponse.kResponseType: TestStatusResponse.fromDynamic,
  };

  /// The optional message associated with the response.
  final String? message;

  /// The type-specific payload.  The value of which is defined by each
  /// sub-class.
  final dynamic payload;

  /// Optional success flag.  If set the process is complete.  If null, the
  /// process associated with the command is still running.
  final bool? success;

  /// The type.  Used to define the payload and response class.
  final String type;

  /// Processes a Map or Map-like object into a response.  If the map is null
  /// then this will return null.
  static CommandResponse? fromDynamic(dynamic map) {
    CommandResponse? result;

    if (map != null) {
      String type = map['type'];

      var builder = _builders[type];
      result = CommandResponse(
        message: map['message'],
        payload: map['payload'],
        success:
            map['success'] == null ? null : JsonClass.parseBool(map['success']),
        type: map['type'],
      );
      if (builder != null) {
        result = builder(map['payload'], result.message, result.success);
      }
    }

    return result;
  }

  /// Allows application to register it's own custom responses.
  static void registerCustomResponses(
          Map<String, CommandResponse Function(dynamic, String?, bool?)>
              builders) =>
      _builders.addAll(builders);

  @override
  Map<String, dynamic> toJson() => {
        'message': message,
        'payload': payload,
        'success': success,
        'type': type,
      };

  @override
  String toString() => json.encode(toJson());
}

/// Response associated with a [ListDevicesCommand] that provides the list of
/// connected devices.
class ListDevicesResponse extends CommandResponse {
  ListDevicesResponse({
    required this.devices,
    String? message,
    bool? success,
  }) : super(
          message: message,
          payload: _toPayload(
            devices: devices,
          ),
          success: success,
          type: kResponseType,
        );

  static const kResponseType = 'list_devices';

  final List<ConnectedDevice> devices;

  static ListDevicesResponse fromDynamic(
    dynamic map,
    String? message,
    bool? success,
  ) {
    late ListDevicesResponse result;

    if (map == null) {
      throw Exception('[ListDevicesResponse.fromDynamic]: map is null');
    } else {
      result = ListDevicesResponse(
        devices: JsonClass.fromDynamicList(
              map['devices'],
              (map) => ConnectedDevice.fromDynamic(map),
            ) ??
            <ConnectedDevice>[],
        message: message,
        success: success,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required List<ConnectedDevice> devices,
  }) =>
      {
        'devices': JsonClass.toJsonList(devices),
      };
}

/// Response associated with a [StartLogStreamCommand] that provides the log
/// entry information.
class LogResponse extends CommandResponse {
  LogResponse({
    String? message,
    required this.record,
    bool? success,
  }) : super(
          message: message,
          payload: _toPayload(
            record: record,
          ),
          success: success,
          type: kResponseType,
        );

  static const kResponseType = 'log';

  final JsonLogRecord record;

  static LogResponse fromDynamic(
    dynamic map,
    String? message,
    bool? success,
  ) {
    late LogResponse result;

    if (map == null) {
      throw Exception('[LogResponse.fromDynamic]: map is null');
    } else {
      result = LogResponse(
        message: message,
        record: JsonLogRecord.fromDynamic(map['record']) ??
            JsonLogRecord(level: Level.SEVERE, message: ''),
        success: success,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required JsonLogRecord record,
  }) =>
      {
        'record': record.toJson(),
      };
}

/// Response containing a screenshot image.  This may come from a
/// [RunTestCommand]'s [ScreenshotStep] or from a
/// [StartScreenshotStreamCommand].
class ScreenshotResponse extends CommandResponse {
  ScreenshotResponse({
    required this.image,
    String? message,
    bool? success,
  }) : super(
          message: message,
          payload: _toPayload(
            image: image,
          ),
          success: success,
          type: kResponseType,
        );

  static const kResponseType = 'screenshot';

  final Uint8List image;

  static ScreenshotResponse fromDynamic(
    dynamic map,
    String? message,
    bool? success,
  ) {
    late ScreenshotResponse result;

    if (map == null) {
      throw Exception('[ScreenshotResponse.fromDynamic]: map is null');
    } else {
      result = ScreenshotResponse(
        image: (map['image'] == null ? null : base64Decode(map['image'])) ??
            Uint8List(0),
        message: message,
        success: success,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({Uint8List? image}) => {
        'image': image == null ? null : base64Encode(image),
      };
}

/// Response that gets sent periodically from a [RunTestCommand].
class TestStatusResponse extends CommandResponse {
  TestStatusResponse({
    this.complete = false,
    this.progress = 0.0,
    String? message,
    required this.report,
    required this.status,
    bool? success,
  }) : super(
          message: message,
          payload: _toPayload(
            complete: complete,
            progress: progress,
            report: report,
            status: status,
          ),
          success: success,
          type: kResponseType,
        );

  static const kResponseType = 'test_status';

  /// Will be true if and only if the test has been completed.
  final bool complete;

  /// The 0-1 based progress of the test run.
  final double progress;

  /// The associated test report.  It will be a partial report on each status
  /// response until [complete] is true.
  final TestReport report;

  /// A displayable status for the current status event.
  final String status;

  static TestStatusResponse fromDynamic(
    dynamic map,
    String? message,
    bool? success,
  ) {
    late TestStatusResponse result;

    if (map == null) {
      throw Exception('[TestStatusResponse.fromDynamic]: map is null');
    } else {
      result = TestStatusResponse(
        complete: JsonClass.parseBool(map['complete']),
        message: message,
        progress: JsonClass.parseDouble(map['progress']) ?? 0.0,
        report: TestReport.fromDynamic(map['report']),
        status: map['status'],
        success: success,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    bool? complete,
    double? progress,
    TestReport? report,
    String? status,
  }) =>
      {
        'complete': complete,
        'progress': progress,
        'report': report?.toJson(),
        'status': status,
      };
}
