import 'dart:convert';

import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:json_class/json_class.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

class DeviceCommand extends JsonClass {
  DeviceCommand({
    String? id,
    required this.payload,
    DateTime? timestamp,
    required this.type,
  })  : id = id ?? Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  static final Map<String, DeviceCommand Function(dynamic, String, DateTime)>
      _builders = {
    AnnounceDeviceCommand.kCommandType: AnnounceDeviceCommand.fromDynamic,
    AnnounceDriverCommand.kCommandType: AnnounceDriverCommand.fromDynamic,
    ChallengeCommand.kCommandType: ChallengeCommand.fromDynamic,
    ChallengeResponseCommand.kCommandType: ChallengeResponseCommand.fromDynamic,
    CommandAck.kCommandType: CommandAck.fromDynamic,
    GoodbyeCommand.kCommandType: GoodbyeCommand.fromDynamic,
    ListDevicesCommand.kCommandType: ListDevicesCommand.fromDynamic,
    ReleaseDeviceCommand.kCommandType: ReleaseDeviceCommand.fromDynamic,
    RequestScreenshotCommand.kCommandType: RequestScreenshotCommand.fromDynamic,
    ReserveDeviceCommand.kCommandType: ReserveDeviceCommand.fromDynamic,
    RunTestCommand.kCommandType: RunTestCommand.fromDynamic,
    StartLogStreamCommand.kCommandType: StartLogStreamCommand.fromDynamic,
    StartScreenshotStreamCommand.kCommandType:
        StartScreenshotStreamCommand.fromDynamic,
    StopLogStreamCommand.kCommandType: StopLogStreamCommand.fromDynamic,
    StopScreenshotStreamCommand.kCommandType:
        StopScreenshotStreamCommand.fromDynamic,
  };

  final String id;
  final dynamic payload;
  final DateTime timestamp;
  final String type;

  static DeviceCommand fromDynamic(dynamic map) {
    late DeviceCommand result;

    if (map == null) {
      throw Exception('[DeviceCommand.fromDynamic]: map is null');
    } else {
      var cmd = DeviceCommand(
        id: map['id'],
        type: map['type'],
        payload: map['payload'],
        timestamp: JsonClass.parseUtcMillis(map['timestamp']),
      );
      result = cmd;

      var builder = _builders[cmd.type];
      if (builder != null) {
        result = builder(cmd.payload, cmd.id, cmd.timestamp);
      }
    }

    return result;
  }

  /// Allows application to register it's own custom commands.
  static void registerCustomCommands(
          Map<String, DeviceCommand Function(dynamic, String, DateTime)>
              builders) =>
      _builders.addAll(builders);

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'payload': payload,
        'timestamp': timestamp.millisecondsSinceEpoch,
        'type': type,
      };

  @override
  String toString() => json.encode(toJson());
}

class AbortTestCommand extends DeviceCommand {
  AbortTestCommand({
    String? id,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'abort_test';

  static AbortTestCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late AbortTestCommand result;

    if (map == null) {
      throw Exception('[AbortTestCommand.fromDynamic]: map is null');
    } else {
      result = AbortTestCommand();
    }

    return result;
  }

  static Map<String, dynamic> _toPayload() => {};
}

class AnnounceDeviceCommand extends DeviceCommand {
  AnnounceDeviceCommand({
    String? id,
    required this.device,
    required this.salt,
    required this.testControllerState,
    DateTime? timestamp,
  })  : appIdentifier = device.appIdentifier,
        super(
          id: id,
          payload: _toPayload(
            appIdentifier: device.appIdentifier,
            device: device,
            salt: salt,
            testControllerState: testControllerState,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'announce_device';

  final String appIdentifier;
  final TestDeviceInfo device;
  final TestControllerState testControllerState;
  final String salt;

  static AnnounceDeviceCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    AnnounceDeviceCommand result;

    if (map == null) {
      throw Exception('[AnnounceDeviceCommand.fromDynamic]: map is null');
    } else {
      result = AnnounceDeviceCommand(
        device: TestDeviceInfo.fromDynamic(map['device']),
        id: id,
        salt: map['salt'],
        testControllerState:
            TestControllerState.fromDynamic(map['testControllerState']),
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required String appIdentifier,
    TestDeviceInfo? device,
    required String salt,
    required TestControllerState testControllerState,
  }) =>
      {
        'appIdentifier': appIdentifier,
        'device': device?.toJson(),
        'salt': salt,
        'testControllerState': testControllerState,
      };
}

class AnnounceDriverCommand extends DeviceCommand {
  AnnounceDriverCommand({
    required this.appIdentifier,
    required this.driverId,
    required this.driverName,
    String? id,
    required this.salt,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            appIdentifier: appIdentifier,
            driverId: driverId,
            driverName: driverName,
            salt: salt,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'announce_driver';

  final String appIdentifier;
  final String driverId;
  final String driverName;
  final String salt;

  static AnnounceDriverCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late AnnounceDriverCommand result;

    if (map == null) {
      throw Exception('[AnnounceDriverCommand.fromDynamic]: map is null');
    } else {
      result = AnnounceDriverCommand(
        appIdentifier: map['appIdentifier'],
        driverId: map['driverId'],
        driverName: map['driverName'],
        id: id,
        salt: map['salt'],
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required String appIdentifier,
    required String driverId,
    required String driverName,
    required String salt,
  }) =>
      {
        'appIdentifier': appIdentifier,
        'driverId': driverId,
        'driverName': driverName,
        'salt': salt,
      };
}

class ChallengeCommand extends DeviceCommand {
  ChallengeCommand({
    String? id,
    required this.salt,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            salt: salt,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'challenge';

  final String salt;

  static ChallengeCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late ChallengeCommand result;

    if (map == null) {
      throw Exception('[ChallengeCommand.fromDynamic]: map is null');
    } else {
      result = ChallengeCommand(
        id: id,
        salt: map['salt'],
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required String salt,
  }) =>
      {
        'salt': salt,
      };
}

class ChallengeResponseCommand extends DeviceCommand {
  ChallengeResponseCommand({
    required this.commandId,
    String? id,
    required this.signature,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            commandId: commandId,
            signature: signature,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'challenge_response';

  final String commandId;
  final String signature;

  static ChallengeResponseCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late ChallengeResponseCommand result;

    if (map == null) {
      throw Exception('[ChallengeResponseCommand.fromDynamic]: map is null');
    } else {
      result = ChallengeResponseCommand(
        commandId: map['commandId'],
        id: id,
        signature: map['signature'],
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required String commandId,
    required String signature,
  }) =>
      {
        'commandId': commandId,
        'signature': signature,
      };
}

class CommandAck extends DeviceCommand {
  CommandAck({
    required this.commandId,
    String? id,
    this.message,
    this.response,
    this.success,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            commandId: commandId,
            message: message,
            response: response,
            success: success,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'ack';

  final String commandId;
  final String? message;
  final CommandResponse? response;
  final bool? success;

  static CommandAck fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late CommandAck result;

    if (map == null) {
      throw Exception('[CommandAck.fromDynamic]: map is null');
    } else {
      result = CommandAck(
        commandId: map['commandId'],
        id: id,
        message: map['message'],
        response: CommandResponse.fromDynamic(map['response']),
        success:
            map['success'] == null ? null : JsonClass.parseBool(map['success']),
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required String commandId,
    String? message,
    CommandResponse? response,
    bool? success,
  }) =>
      {
        'commandId': commandId,
        'message': message,
        'response': response?.toJson(),
        'success': success,
      };
}

class GoodbyeCommand extends DeviceCommand {
  GoodbyeCommand({
    this.complete = false,
    String? id,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            complete: complete,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'goodbye';

  final bool complete;

  static GoodbyeCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    GoodbyeCommand result;

    if (map == null) {
      throw Exception('[GoodbyeCommand.fromDynamic]: map is null');
    } else {
      result = GoodbyeCommand(
        id: id,
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required bool complete,
  }) =>
      {
        'complete': complete,
      };
}

class ListDevicesCommand extends DeviceCommand {
  ListDevicesCommand({
    this.availableOnly = false,
    String? id,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(availableOnly: availableOnly),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'list_devices';

  final bool availableOnly;

  static ListDevicesCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late ListDevicesCommand result;

    if (map == null) {
      throw Exception('[ListDevicesCommand.fromDynamic]: map is null');
    } else {
      result = ListDevicesCommand(
        availableOnly: JsonClass.parseBool(map['availableOnly']),
        id: id,
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required bool availableOnly,
  }) =>
      {
        'availableOnly': availableOnly,
      };
}

class PingCommand extends DeviceCommand {
  PingCommand({
    String? id,
    this.testControllerState,
    this.testDeviceInfo,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            testControllerState: testControllerState,
            testDeviceInfo: testDeviceInfo,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'ping';

  final TestControllerState? testControllerState;
  final TestDeviceInfo? testDeviceInfo;

  static PingCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late PingCommand result;

    if (map == null) {
      throw Exception('[PingCommand.fromDynamic]: map is null');
    } else {
      result = PingCommand(
        id: id,
        testControllerState: map['testControllerState'] == null
            ? null
            : TestControllerState.fromDynamic(map['testControllerState']),
        testDeviceInfo: map['testDeviceInfo'] == null
            ? null
            : TestDeviceInfo.fromDynamic(map['testDeviceInfo']),
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    TestControllerState? testControllerState,
    TestDeviceInfo? testDeviceInfo,
  }) =>
      {
        'testControllerState': testControllerState?.toJson(),
        'testDeviceInfo': testDeviceInfo?.toJson(),
      };
}

class ReleaseDeviceCommand extends DeviceCommand {
  ReleaseDeviceCommand({
    required this.deviceId,
    String? id,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            deviceId: deviceId,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'release_device';

  final String deviceId;

  static ReleaseDeviceCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late ReleaseDeviceCommand result;

    if (map == null) {
      throw Exception('[ReleaseDeviceCommand.fromDynamic]: map is null');
    } else {
      result = ReleaseDeviceCommand(
        deviceId: map['deviceId'],
        id: id,
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required String deviceId,
  }) =>
      {
        'deviceId': deviceId,
      };
}

class RequestScreenshotCommand extends DeviceCommand {
  RequestScreenshotCommand({
    required this.deviceId,
    String? id,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            deviceId: deviceId,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'request_screenshot';

  final String deviceId;

  static RequestScreenshotCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    RequestScreenshotCommand result;

    if (map == null) {
      throw Exception('[RequestScreenshotCommand.fromDynamic]: map is null');
    } else {
      result = RequestScreenshotCommand(
        deviceId: map['deviceId'],
        id: id,
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required String deviceId,
  }) =>
      {
        'deviceId': deviceId,
      };
}

class ReserveDeviceCommand extends DeviceCommand {
  ReserveDeviceCommand({
    required this.deviceId,
    required this.driverName,
    String? id,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            deviceId: deviceId,
            driverName: driverName,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'reserve_device';

  final String deviceId;
  final String driverName;

  static ReserveDeviceCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    ReserveDeviceCommand result;

    if (map == null) {
      throw Exception('[ReserveDeviceCommand.fromDynamic]: map is null');
    } else {
      result = ReserveDeviceCommand(
        deviceId: map['deviceId'],
        driverName: map['driverName'],
        id: id,
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required String deviceId,
    required String driverName,
  }) =>
      {
        'deviceId': deviceId,
        'driverName': driverName,
      };
}

class RunTestCommand extends DeviceCommand {
  RunTestCommand({
    String? id,
    required this.sendScreenshots,
    required this.test,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            test: test,
            sendScreenshots: sendScreenshots,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'run_test';

  final bool sendScreenshots;
  final Test test;

  static RunTestCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late RunTestCommand result;

    if (map == null) {
      throw Exception('[RunTestCommand.fromDynamic]: map is null');
    } else {
      result = RunTestCommand(
        id: id,
        sendScreenshots: JsonClass.parseBool(map['sendScreenshots']),
        test: Test.fromDynamic(map['test']),
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required bool sendScreenshots,
    required Test test,
  }) =>
      {
        'sendScreenshots': sendScreenshots,
        'test': test.toJson(),
      };
}

class StartLogStreamCommand extends DeviceCommand {
  StartLogStreamCommand({
    String? id,
    this.level = Level.INFO,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(
            level: level,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'start_log_stream';

  final Level level;

  static StartLogStreamCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late StartLogStreamCommand result;

    if (map == null) {
      throw Exception('[StartLogStreamCommand.fromDynamic]: map is null');
    } else {
      result = StartLogStreamCommand(
        id: id,
        level: Level.LEVELS.where((level) => level.name == map['level']).first,
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required Level level,
  }) =>
      {
        'level': level.toString(),
      };
}

class StartScreenshotStreamCommand extends DeviceCommand {
  StartScreenshotStreamCommand({
    String? id,
    this.interval = const Duration(seconds: 5),
    DateTime? timestamp,
  })  : assert(interval.inSeconds >= 1),
        super(
          id: id,
          payload: _toPayload(
            interval: interval,
          ),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'start_screenshot_stream';

  final Duration interval;

  static StartScreenshotStreamCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late StartScreenshotStreamCommand result;

    if (map == null) {
      throw Exception(
          '[StartScreenshotStreamCommand.fromDynamic]: map is null');
    } else {
      result = StartScreenshotStreamCommand(
        id: id,
        interval: JsonClass.parseDurationFromMillis(map['interval']) ??
            const Duration(seconds: 5),
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload({
    required Duration interval,
  }) =>
      {
        'interval': interval.inMilliseconds,
      };
}

class StopLogStreamCommand extends DeviceCommand {
  StopLogStreamCommand({
    String? id,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'stop_log_stream';

  static StopLogStreamCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late StopLogStreamCommand result;

    if (map == null) {
      throw Exception('[StopLogStreamCommand.fromDynamic]: map is null');
    } else {
      result = StopLogStreamCommand(
        id: id,
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload() => {};
}

class StopScreenshotStreamCommand extends DeviceCommand {
  StopScreenshotStreamCommand({
    String? id,
    DateTime? timestamp,
  }) : super(
          id: id,
          payload: _toPayload(),
          timestamp: timestamp,
          type: kCommandType,
        );

  static const kCommandType = 'stop_screenshot_stream';

  static StopScreenshotStreamCommand fromDynamic(
    dynamic map,
    String id,
    DateTime timestamp,
  ) {
    late StopScreenshotStreamCommand result;

    if (map == null) {
      throw Exception('[StopScreenshotStreamCommand.fromDynamic]: map is null');
    } else {
      result = StopScreenshotStreamCommand(
        id: id,
        timestamp: timestamp,
      );
    }

    return result;
  }

  static Map<String, dynamic> _toPayload() => {};
}
