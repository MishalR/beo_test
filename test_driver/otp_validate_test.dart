// This is a basic Flutter Driver test for the application. A Flutter Driver
// test is an end-to-end test that "drives" your application from another
// process or even from another computer. If you are familiar with
// Selenium/WebDriver for web, Espresso for Android or UI Automation for iOS,
// this is simply Flutter's version of that.

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('OTP App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    final loaderFinder = find.byType('InkWell');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('loader12', () async {
      // First, tap the button.
      await driver.runUnsynchronized(() async {
        await driver.tap(loaderFinder);
      });




      // Then, verify the counter text is incremented by 1.
      //expect(await driver.getText(usernameFinder), "Hello!");
    });
  });
}
