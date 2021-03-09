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
