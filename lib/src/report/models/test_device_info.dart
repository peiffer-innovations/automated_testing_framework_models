import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:meta/meta.dart';
import 'package:json_class/json_class.dart';

/// Container class for the device information for the device the test is being
/// executed on.
@immutable
class TestDeviceInfo extends JsonClass implements Comparable<TestDeviceInfo> {
  TestDeviceInfo.custom({
    @required this.appIdentifier,
    @required this.brand,
    @required this.buildNumber,
    @required this.device,
    @required this.deviceGroup,
    @required this.devicePixelRatio,
    @required this.dips,
    @required this.id,
    @required this.manufacturer,
    @required this.model,
    @required this.os,
    @required this.orientation,
    bool physicalDevice = true,
    @required this.pixels,
    @required this.systemVersion,
  }) : physicalDevice = physicalDevice ?? true {
    instance = this;
  }

  static TestDeviceInfo instance;

  final String appIdentifier;
  final String brand;
  final String buildNumber;
  final String device;
  final String deviceGroup;
  final double devicePixelRatio;
  final BaseSize dips;
  final String id;
  final String manufacturer;
  final String model;
  final String orientation;
  final String os;
  final bool physicalDevice;
  final BaseSize pixels;
  final String systemVersion;

  static TestDeviceInfo fromDynamic(dynamic map) {
    TestDeviceInfo result;

    if (map != null) {
      var screen = map['screen'] ?? {};

      result = TestDeviceInfo.custom(
        appIdentifier: map['appIdentifier'],
        brand: map['brand'],
        buildNumber: map['buildNumber'],
        device: map['device'],
        deviceGroup: map['deviceGroup'],
        devicePixelRatio: JsonClass.parseDouble(screen['devicePixelRatio']),
        dips: BaseSize.fromDynamic(screen['dips']),
        id: map['id'],
        manufacturer: map['manufacturer'],
        model: map['model'],
        orientation: map['orientation'],
        os: map['os'],
        physicalDevice: JsonClass.parseBool(map['physicalDevice']),
        pixels: BaseSize.fromDynamic(screen['pixels']),
        systemVersion: map['systemVersion'],
      );
    }

    return result;
  }

  String get deviceSignature => [
        appIdentifier,
        buildNumber,
        os,
        manufacturer,
        model,
        physicalDevice,
        systemVersion,
      ].join('_');

  @override
  int compareTo(TestDeviceInfo other) {
    var result = 0;

    result = os.compareTo(other.os);
    if (result == 0) {
      var thisModel = os == 'ios' ? device : model;

      var otherModel = other.os == 'ios' ? other.device : other.model;
      result = thisModel.toLowerCase().compareTo(otherModel.toLowerCase());
    }
    if (result == 0) {
      result = id.compareTo(other.id);
    }

    return result;
  }

  TestDeviceInfo copyWith({
    String appIdentifier,
    String brand,
    String buildNumber,
    String device,
    String deviceGroup,
    double devicePixelRatio,
    BaseSize dips,
    String id,
    String manufacturer,
    String model,
    String orientation,
    String os,
    bool physicalDevice,
    BaseSize pixels,
    String systemVersion,
  }) =>
      TestDeviceInfo.custom(
        appIdentifier: appIdentifier ?? this.appIdentifier,
        brand: brand ?? this.brand,
        buildNumber: buildNumber ?? this.brand,
        device: device ?? this.device,
        deviceGroup: deviceGroup ?? this.deviceGroup,
        devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
        dips: dips ?? this.dips,
        id: id ?? this.id,
        manufacturer: manufacturer ?? this.manufacturer,
        model: model ?? this.model,
        orientation: orientation ?? this.orientation,
        os: os ?? this.os,
        physicalDevice: physicalDevice ?? this.physicalDevice,
        pixels: pixels ?? this.pixels,
        systemVersion: systemVersion ?? this.systemVersion,
      );

  @override
  Map<String, dynamic> toJson() => {
        'appIdentifier': appIdentifier,
        'brand': brand,
        'buildNumber': buildNumber,
        'device': device,
        'deviceGroup': deviceGroup,
        'id': id,
        'manufacturer': manufacturer,
        'model': model,
        'orientation': orientation,
        'os': os,
        'physicalDevice': physicalDevice,
        'screen': devicePixelRatio == null
            ? null
            : {
                'devicePixelRatio': devicePixelRatio,
                'dips': dips?.toJson(),
                'pixels': pixels?.toJson(),
              },
        'systemVersion': systemVersion,
      };
}
