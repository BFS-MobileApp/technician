import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/login/domain/entities/login.dart';

abstract class LoginRepository {

  Future<Either<Failures , Login>> login(String email , String password, bool rememberMe);

  Future<void> saveUserInfo(String email , String name , String token, bool rememberMe);
}
