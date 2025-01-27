import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';

abstract class ResetPasswordRepository{

  Future<Either<Failures , bool>> resetPassword(String email , String token , String password , String confirmPassword);
}