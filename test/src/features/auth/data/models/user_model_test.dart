import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:bluebank_app/src/features/auth/data/models/user_model.dart';
import 'package:bluebank_app/src/features/auth/domain/entities/user.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(id: '1', email: 'test@test.com');

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));
      // act
      final result = UserModel.fromJson(jsonMap);
      // assert
      expect(result, tUserModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = tUserModel.toJson();
      // assert
      final expectedMap = {"id": "1", "email": "test@test.com"};
      expect(result, expectedMap);
    });
  });

  group('toEntity', () {
    test('should return a User entity', () {
      // act
      final result = tUserModel.toEntity();
      // assert
      expect(result, isA<User>());
    });
  });
}
