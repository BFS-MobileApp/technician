import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/forgot%20password/domain/repositories/forgot_password_repository.dart';

class ForgotPasswordUseCase implements UseCase<bool , ForgotPasswordParams>{

  final ForgotPasswordRepository forgotPasswordRepository;
  ForgotPasswordUseCase({required this.forgotPasswordRepository});

  @override
  Future<Either<Failures, bool>> call(ForgotPasswordParams params) => forgotPasswordRepository.forgotPassword(params.email);

}