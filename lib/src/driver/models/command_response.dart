import 'dart:convert';
import 'dart:typed_data';

import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:json_class/json_class.dart';
import 'package:logging/logging.dart';

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

  final String? message;
  final dynamic? payload;
  final bool? success;
  final String type;

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

  final bool complete;
  final double progress;
  final TestReport report;
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
