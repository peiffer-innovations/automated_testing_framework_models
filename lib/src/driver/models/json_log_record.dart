import 'package:json_class/json_class.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

class JsonLogRecord extends JsonClass {
  JsonLogRecord({
    this.error,
    @required this.level,
    this.loggerName,
    this.message,
    this.object,
    this.sequenceNumber,
    this.stackTrace,
    this.time,
  });

  static JsonLogRecord fromDynamic(dynamic map) {
    JsonLogRecord result;

    if (map != null) {
      result = JsonLogRecord(
        error: map['error'],
        level: Level.LEVELS.where((level) => level.name == map['level']).first,
        loggerName: map['loggerName'],
        message: map['message'],
        object: map['object'],
        sequenceNumber: JsonClass.parseInt(map['sequenceNumber']),
        stackTrace: map['stackTrace'],
        time: JsonClass.parseUtcMillis(map['time']),
      );
    }

    return result;
  }

  static JsonLogRecord fromLogRecord(LogRecord record) {
    JsonLogRecord result;

    if (record != null) {
      result = JsonLogRecord(
        error: record.error?.toString(),
        level: record.level,
        loggerName: record.loggerName,
        message: record.message,
        object: record.object?.toString(),
        sequenceNumber: record.sequenceNumber,
        stackTrace: record.stackTrace?.toString(),
        time: record.time,
      );
    }

    return result;
  }

  /// Associated error (if any) when recording errors messages.
  final String error;

  final Level level;

  /// Logger where this record is stored.
  final String loggerName;

  final String message;

  /// Non-string message passed to Logger.
  final String object;

  /// Unique sequence number greater than all log records created before it.
  final int sequenceNumber;

  /// Associated stackTrace (if any) when recording errors messages.
  final String stackTrace;

  /// Time when this record was created.
  final DateTime time;

  @override
  Map<String, dynamic> toJson() => {
        'error': error,
        'level': level.name,
        'loggerName': loggerName,
        'message': message,
        'object': object,
        'sequenceNumber': sequenceNumber,
        'stackTrace': stackTrace,
        'time': time?.millisecondsSinceEpoch,
      };
}
