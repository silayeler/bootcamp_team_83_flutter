import 'package:flutter_test/flutter_test.dart';
import 'package:bootcamp_team_83_flutter/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('LoginViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
