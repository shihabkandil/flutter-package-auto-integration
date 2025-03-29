import 'package:auto_pi/common/core/either.dart';
import 'package:flutter_test/flutter_test.dart';

Either<String, double> divide(double a, double b) {
  if (b == 0) {
    return Either.left('Division by zero is not allowed');
  } else {
    return Either.right(a / b);
  }
}

void main() {
  group('Either class tests', () {
    test('should return Left for error case (failure)', () {
      final result = divide(10, 0);

      expect(result, isA<Left<String, double>>());
      result.fold(
        (left) => expect(left, 'Division by zero is not allowed'),
        (right) => fail('Expected Left, but got Right'),
      );
    });

    test('should return Right for successful case (valid division)', () {
      final result = divide(10, 2);

      expect(result, isA<Right<String, double>>());
      result.fold(
        (left) => fail('Expected Right, but got Left'),
        (right) => expect(right, 5.0),
      );
    });

    test('should return Left for failure case with custom error message', () {
      final result = divide(5, 0);

      result.fold(
        (left) => expect(left, 'Division by zero is not allowed'),
        (right) => fail('Expected Left, but got Right'),
      );
    });

    test(
      'should return Right for valid division case with non-zero result',
      () {
        final result = divide(20, 4);

        result.fold(
          (left) => fail('Expected Right, but got Left'),
          (right) => expect(right, 5.0),
        );
      },
    );
  });
}
