import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:test/test.dart';

void main() {
  test('BaseSize', () {
    var baseSize = BaseSize(1.0, 2.0);
    expect(baseSize.height, 2.0);
    expect(baseSize.width, 1.0);
  });
}
