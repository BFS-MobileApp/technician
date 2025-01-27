import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';

abstract class ForgotPasswordRepository{

  Future<Either<Failures , bool>> forgotPassword(String email);
}