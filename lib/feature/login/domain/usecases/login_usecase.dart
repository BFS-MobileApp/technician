import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/login/domain/entities/login.dart';
import 'package:technician/feature/login/domain/repositories/login_repository.dart';

class LoginUseCase implements UseCase<Login , LoginParams>{

  final LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failures, Login>> call(LoginParams params) => loginRepository.login(params.email, params.password , params.rememberMe);
  
}