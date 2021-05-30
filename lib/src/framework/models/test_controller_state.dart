import 'dart:async';

import 'package:json_class/json_class.dart';

class TestControllerState extends JsonClass {
  TestControllerState({
    String? currentStep,
    String? currentTest,
    bool passing = false,
    double progress = 0.0,
    bool runningSuite = false,
    bool runningTest = false,
  })  : _currentStep = currentStep,
        _currentTest = currentTest,
        _passing = passing,
        _progress = progress,
        _runningSuite = runningSuite,
        _runningTest = runningTest;

  final StreamController<String?> _currentStepStreamController =
      StreamController<String?>.broadcast();
  final StreamController<String?> _currentTestStreamController =
      StreamController<String?>.broadcast();
  final StreamController<bool> _passingStreamController =
      StreamController<bool>.broadcast();
  final StreamController<double> _progressStreamController =
      StreamController<double>.broadcast();
  final StreamController<bool> _runningSuiteStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _runningTestStreamController =
      StreamController<bool>.broadcast();

  String? _currentStep;
  String? _currentTest;
  bool _passing;
  double _progress;
  bool _runningTest;
  bool _runningSuite;

  /// Returns the name of the current step or null if no step is currently
  /// running.
  String? get currentStep => _currentStep;

  /// Returns the name of the current test or null if no test is currently
  /// running.
  String? get currentTest => _currentTest;

  /// Returns whether or not the test is currently passing.  Will be false if no
  /// test is currently running.
  bool get passing => _passing;

  /// Returns the current progress within a test run or 0 if no test is running.
  double get progress => _progress;

  /// Returns whether or not a test suite is running.  To know if anything is
  /// running, clients should OR this against [runningTest].
  bool get runningSuite => _runningSuite;

  /// Returns whether or not an individual test is running.  To know if anything
  /// is running, clients should OR this against [runningSuite].
  bool get runningTest => _runningTest;

  /// Stream that fires whenever the test controller starts a new test step.
  Stream<String?> get currentStepStream => _currentStepStreamController.stream;

  /// Stream that fires whenever the test controller starts a new test.
  Stream<String?> get currentTestStream => _currentTestStreamController.stream;

  /// Stream that fires whenever the passing state for a test changes.
  Stream<bool> get passingStream => _passingStreamController.stream;

  /// Stream that fires whenever the progress of a test run changes.
  Stream<double> get progressStream => _progressStreamController.stream;

  /// Stream that fires whenever a test starts or finishes running.
  Stream<bool> get runningTestStream => _runningTestStreamController.stream;

  /// Stream that fires whenever a test starts or finishes running.
  Stream<bool> get runningSuiteStream => _runningSuiteStreamController.stream;

  /// Sets the name of the current running step; may be null if there is no test
  /// step currently running.
  set currentStep(String? step) {
    if (_currentStep != step) {
      _currentStep = step;
      _currentStepStreamController.add(step);
    }
  }

  /// Sets the name of the current running test; may be null if there is no test
  /// currently running.
  set currentTest(String? test) {
    if (_currentTest != test) {
      _currentTest = test;
      _currentTestStreamController.add(test);
    }
  }

  /// Sets whether or not a test is currently passing.  The value false may be
  /// used to indicate no test is running or the current test is failing.
  set passing(bool passing) {
    if (_passing != passing) {
      _passing = passing;
      _passingStreamController.add(passing);
    }
  }

  /// Sets the current progress of the test run.  The value 0 may be used to
  /// indicate a test has just started or no test is currently running.
  set progress(double progress) {
    if (_progress != progress) {
      _progress = progress;
      _progressStreamController.add(progress);
    }
  }

  /// Sets whether or not a test suite is running.
  set runningSuite(bool runningSuite) {
    if (_runningSuite != runningSuite) {
      _runningSuite = runningSuite;
      _runningTestStreamController.add(runningSuite);
    }
  }

  /// Sets whether or not a test is running.
  set runningTest(bool runningTest) {
    if (_runningTest != runningTest) {
      _runningTest = runningTest;
      _runningTestStreamController.add(runningTest);
    }
  }

  static TestControllerState fromDynamic(dynamic map) {
    late TestControllerState result;

    if (map == null) {
      throw Exception('[TestControllerState.fromDynamic]: map is null');
    } else {
      result = TestControllerState(
        currentStep: map['currentStep'],
        currentTest: map['currentTest'],
        passing: JsonClass.parseBool(map['passing']),
        progress: JsonClass.parseDouble(map['progress'], 0.0) ?? 0.0,
        runningSuite: JsonClass.parseBool(map['runningSuite']),
        runningTest: JsonClass.parseBool(map['runningTest']),
      );
    }

    return result;
  }

  /// Disposes the controller state.
  void dispose() {
    _currentStepStreamController.close();
    _currentTestStreamController.close();
    _passingStreamController.close();
    _progressStreamController.close();
    _runningSuiteStreamController.close();
    _runningTestStreamController.close();
  }

  @override
  Map<String, dynamic> toJson() => {
        'currentStep': currentStep,
        'currentTest': currentTest,
        'passing': passing,
        'progress': progress,
        'runningSuite': runningSuite,
        'runningTest': runningTest,
      };
}
