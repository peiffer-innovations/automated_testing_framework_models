import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';

class ConnectedDevice extends JsonClass {
  ConnectedDevice({
    @required this.device,
    this.driverName,
    @required this.testControllerState,
  })  : assert(device != null),
        assert(testControllerState != null);

  final TestDeviceInfo device;
  final String driverName;
  final TestControllerState testControllerState;

  static ConnectedDevice fromDynamic(dynamic map) {
    ConnectedDevice result;

    if (map != null) {
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
