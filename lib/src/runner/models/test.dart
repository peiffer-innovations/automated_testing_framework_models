import 'dart:math';

import 'package:automated_testing_framework_models/automated_testing_framework_models.dart';
import 'package:json_class/json_class.dart';

/// PODO for a test that can be executed.
class Test extends JsonClass {
  /// Constructs the test.
  Test({
    this.active = true,
    this.name,
    int? pinnedStepIndex,
    List<TestStep>? steps,
    this.suiteName,
    DateTime? timestamp,
    this.version = 0,
  })  : steps = steps == null ? <TestStep>[] : List<TestStep>.from(steps),
        timestamp = timestamp ?? DateTime.now() {
    this.pinnedStepIndex =
        min(pinnedStepIndex ?? this.steps.length - 1, this.steps.length - 1);
  }

  /// Sets whether or not this test is currently active.  The interal system
  /// will always create active tests but loaders may return inactive tests.
  final bool active;

  /// The name for the test
  final String? name;

  /// The list of steps for the test
  final List<TestStep> steps;

  /// The name of the test suite this test is a part of; may be `null` or empty.
  final String? suiteName;

  /// The timestamp for the test step.
  final DateTime timestamp;

  /// The test version.
  final int version;

  /// The index of the currently pinned step.  The pinned step is the step after
  /// which steps will be added via [addStep].  This is intended to allow users
  /// to add steps in the middle of an existing step as opposed to always having
  /// to add steps to the end of a test and then manually reorder them.
  ///
  /// Although it may be slightly unintuitive, this is actually -1 based.  That
  /// is because the step is aways added after this index which means a value of
  /// -1 adds the test step to the zeroth (first) position, a value of zero
  /// would add test step to the oneth (second) position, and so on.
  int pinnedStepIndex = -1;

  /// Creates a test from a map-like object.  The [map] must support the `[]`
  /// operator if it is not `null`.
  ///
  /// This expects a JSON-like object in the following form:
  /// ```json
  /// {
  ///   "active": <bool>,
  ///   "name": <String>,
  ///   "steps": <List<TestStep>>,
  ///   "suiteName": <String>,
  ///   "timestamp": <number; millis since epoch>,
  ///   "version": <number>
  /// }
  /// ```
  static Test fromDynamic(
    dynamic map, {
    bool ignoreImages = false,
  }) {
    late Test result;

    if (map == null) {
      throw Exception('[Test.fromDynamic]: map is null');
    } else {
      result = Test(
        active:
            map['active'] == null ? true : JsonClass.parseBool(map['active']),
        name: map['name'],
        steps: JsonClass.fromDynamicList(
            map['steps'],
            (map) => TestStep.fromDynamic(
                  map,
                  ignoreImages: ignoreImages,
                )),
        suiteName: map['suiteName'],
        timestamp: JsonClass.parseUtcMillis(
          map['timestamp'],
          DateTime.now().millisecondsSinceEpoch,
        ),
        version: JsonClass.parseInt(map['version'], 1) ?? 1,
      );
    }

    return result;
  }

  /// Adds a test step to this test at the current [pinnedStepIndex] and
  /// increments [pinnedStepIndex] by one.
  void addTestStep(TestStep step) => steps.insert(++pinnedStepIndex, step);

  /// Clears all test steps from this test.
  void clearTestSteps() {
    steps.clear();
    pinnedStepIndex = 0;
  }

  /// Returns the id of the test which is a concatenation of the suite
  /// name and the test name.
  String get id =>
      '${(suiteName?.isNotEmpty == true ? '${suiteName}__' : '')}$name';

  /// Copies this test with the given values.
  Test copyWith({
    bool? active,
    String? name,
    int? pinnedStepIndex,
    List<TestStep>? steps,
    String? suiteName,
    DateTime? timestamp,
    int? version,
  }) =>
      Test(
        active: active ?? this.active,
        name: name ?? this.name,
        pinnedStepIndex: pinnedStepIndex ?? this.pinnedStepIndex,
        steps: steps ?? this.steps,
        suiteName: suiteName ?? this.suiteName,
        timestamp: timestamp ?? this.timestamp,
        version: version ?? this.version,
      );

  /// Converts this test to a JSON compatible format.  See [fromDynamic] for the
  /// structure.
  @override
  Map<String, dynamic> toJson() => {
        'active': active,
        'name': name,
        'steps': JsonClass.toJsonList(steps),
        'suiteName': suiteName,
        'timestamp': timestamp.millisecondsSinceEpoch,
        'version': version,
      };
}
