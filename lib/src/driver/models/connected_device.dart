import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:json_class/json_class.dart';

class ConnectedDevice extends JsonClass {
  ConnectedDevice({
    required this.device,
    this.driverName,
    required this.testControllerState,
  });

  final TestDeviceInfo device;
  final String? driverName;
  final TestControllerState testControllerState;

  static ConnectedDevice fromDynamic(dynamic map) {
    late ConnectedDevice result;

    if (map == null) {
      throw Exception('[ConnectedDevice.fromDynamic]: map is null');
    } else {
      result = ConnectedDevice(
        device: TestDeviceInfo.fromDynamic(map['device']),
        driverName: map['driverName'],
        testControllerState: TestControllerState.fromDynamic(
          map['testControllerState'],
        ),
      );
    }

    return result;
  }

  @override
  Map<String, dynamic> toJson() => {
        'device': device.toJson(),
        'driverName': driverName,
        'testControllerState': testControllerState.toJson(),
      };
}
