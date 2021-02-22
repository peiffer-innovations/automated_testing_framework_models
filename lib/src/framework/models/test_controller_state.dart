import 'package:json_class/json_class.dart';

class TestControllerState extends JsonClass {
  TestControllerState({
    this.currentStep,
    this.currentTest,
    this.passing = false,
    this.progress = 0.0,
    this.runningSuite = false,
    this.runningTest = false,
  });

  String currentStep;
  String currentTest;
  bool passing;
  double progress;
  bool runningSuite;
  bool runningTest;
  DateTime updated;

  static TestControllerState fromDynamic(dynamic map) {
    TestControllerState result;

    if (map != null) {
      result = TestControllerState(
        currentStep: map['currentStep'],
        currentTest: map['currentTest'],
        passing: JsonClass.parseBool(map['passing']),
        progress: JsonClass.parseDouble(map['progress'], 0.0),
        runningSuite: JsonClass.parseBool(map['runningSuite']),
        runningTest: JsonClass.parseBool(map['runningTest']),
      );
    }

    return result;
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
