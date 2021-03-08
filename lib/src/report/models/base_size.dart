import 'package:json_class/json_class.dart';

class BaseSize extends JsonClass {
  BaseSize(
    this.width,
    this.height,
  );

  final double height;
  final double width;

  static BaseSize? fromDynamic(dynamic map) {
    BaseSize? result;

    if (map != null) {
      result = BaseSize(
        JsonClass.parseDouble(map['width']) ?? 0.0,
        JsonClass.parseDouble(map['height']) ?? 0.0,
      );
    }

    return result;
  }

  @override
  Map<String, dynamic> toJson() => {
        'height': height,
        'width': width,
      };
}
