import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/error/failures.dart';

abstract class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
