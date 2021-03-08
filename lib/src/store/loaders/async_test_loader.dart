import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';

/// Loader that loads the test from an async callback.
class AsyncTestLoader extends TestLoader {
  /// Constructs the loader with the callback to use.
  AsyncTestLoader(
    this.callback,
  );

  /// The callback to execute to get the test.
  final Future<Test> Function() callback;

  /// Returns the in test by executing the callback;
  @override
  Future<Test> load({bool ignoreImages = false}) => callback();
}
