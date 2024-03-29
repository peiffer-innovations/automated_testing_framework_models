## [2.0.10+8] - April 25, 2023

* Automated dependency updates


## [2.0.10+7] - April 18, 2023

* Automated dependency updates


## [2.0.10+6] - April 4, 2023

* Automated dependency updates


## [2.0.10+5] - March 28, 2023

* Automated dependency updates


## [2.0.10+4] - March 21, 2023

* Automated dependency updates


## [2.0.10+3] - March 7, 2023

* Automated dependency updates


## [2.0.10+2] - February 14, 2023

* Automated dependency updates


## [2.0.10+1] - January 31, 2023

* Automated dependency updates


## [2.0.10] - January 24th, 2023

* Flutter 3.7


## [2.0.9+16] - January 17, 2023

* Automated dependency updates


## [2.0.9+15] - January 3, 2023

* Automated dependency updates


## [2.0.9+14] - December 20, 2022

* Automated dependency updates


## [2.0.9+13] - December 13, 2022

* Automated dependency updates


## [2.0.9+12] - November 15, 2022

* Automated dependency updates


## [2.0.9+11] - November 8, 2022

* Automated dependency updates


## [2.0.9+10] - November 1, 2022

* Automated dependency updates


## [2.0.9+9] - October 18, 2022

* Automated dependency updates


## [2.0.9+8] - September 13, 2022

* Automated dependency updates


## [2.0.9+7] - September 6, 2022

* Automated dependency updates


## [2.0.9+6] - July 26, 2022

* Automated dependency updates


## [2.0.9+5] - July 12, 2022

* Automated dependency updates


## [2.0.9+4] - June 28, 2022

* Automated dependency updates


## [2.0.9+3] - June 21, 2022

* Automated dependency updates


## [2.0.9+2] - May, 31, 2022

* Automated dependency updates


## [2.0.9+1] - May, 30, 2022

* Automated dependency updates


## [2.0.9] - May 14th, 2022

* Flutter 3.0


## [2.0.8+4] - April 16th, 2022

* Dependency updates


## [2.0.8+3] - February 6th, 2022

* Dependency updates


## [2.0.8+2] - January 15th, 2022

* Dependency updates


## [2.0.8+1] - January 9th, 2022

* Dependency updates


## [2.0.8] - October 3rd, 2021

* Removed unused `HeartbeatCommand`


## [2.0.7+4] - September 19th, 2021

* Dependency updates


## [2.0.7+3] - September 18th, 2021

* Dependency updates


## [2.0.7+2] - August 22nd, 2021

* Dependency updates


## [2.0.7+1] - July 23rd, 2021

* Dependency updates


## [2.0.6] - June 21st, 2021

* Added `pinnedStepIndex` to `Test` to allow for easily adding steps to places other than the end of the test.


## [2.0.5] - May 31th, 2021

* Added documentation to `CommandResponse` and `DeviceCommand`.
* Added `HeartbeatCommand`.


## [2.0.4] - May 30th, 2021

* Added streams to the `TestControllerState` so clients can listen to state updates.


## [2.0.3+2] - May 29st, 2021

* Updated with latest static code analysis rules
* Dependency updates


## [2.0.3] - May 21st, 2021

* Added `fromDynamicNullable` to `TestStep`.


## [2.0.2] - April 13, 2021

* Added static launch id to the `TestDeviceInfo` to create a unique and stable id for each app launch


## [2.0.1+1] - April 13, 2021

* Added device info to `PingCommand`


## [2.0.1] - April 3rd, 2021

* Fix for updating the `success` attribute to allow `null` from JSON when decoding
* Updated dependencies


## [2.0.0+2] - March 30th, 2021

* Fix for a flipped equality comparison in `ListDevicesCommand`.


## [2.0.0+1] - March 8th, 2021

* Minor Null Safety bug fixes


## [2.0.0] - March 7th, 2021

* Null Safety


## [1.1.1] - February 28th, 2021

* Updated `DeviceCommand` to expose the constructor.
* Fixed `RunTestCommand` encoder to ensure the `sendScreenshots` is sent.


## [1.1.0] - February 21st, 2021

* Added models to better support a new realtime driver.


## [1.0.5+3] - January 17th, 2021

* Dependency updates


## [1.0.5+2] - January 12th, 2021

* Fix to properly deserialize `TestReportMetadata`.
* Added ability to override id in `TestReportMetadata`.


## [1.0.4] - January 11th, 2021

* Fix to properly serialize `TestReportMetadata`.


## [1.0.3+1] - January 9th, 2021

* Added JSON processing to `TestReportMetadata`.


## [1.0.3] - January 9th, 2021

* Added `TestReportMetadata` to allow for simplified report analytics.


## [1.0.2+1] - December 4th, 2020

* Updated to emit id on `TestReport.toJson`.


## [1.0.2] - December 4th, 2020

* Fix for when there are no logs in the `TestReport`.


## [1.0.1] - December 2nd, 2020

* Added id to `TestReport.fromDynamic`.


## [1.0.0+2] - November 3rd, 2020

* Renamed `BaseTestDeviceInfo` back to `TestDeviceInfo`.


## [1.0.0+1] - November 2nd, 2020

* Fixed inverted logic on `errorSteps` in `TestReport`.


## [1.0.0] - October 31st, 2020

* Splitted several core models out to be pure dart compatible.
























