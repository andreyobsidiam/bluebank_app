#!/bin/zsh

# Generate lcov.info
flutter test --coverage

# Remove generated files from coverage report
# You might need to install lcov: brew install lcov
lcov --remove coverage/lcov.info 'lib/**/*.freezed.dart' 'lib/**/*.g.dart' 'lib/src/core/di/injector.config.dart' -o coverage/lcov.info

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open the report
open coverage/html/index.html