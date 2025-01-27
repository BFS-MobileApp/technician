import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/reset_password/domain/repositories/reset_password_repository.dart';

class ResetPasswordUseCase implements UseCase<bool , ResetPasswordParams>{

  final ResetPasswordRepository resetPasswordRepository;
  ResetPasswordUseCase({required this.resetPasswordRepository});

  @override
  Future<Either<Failures, bool>> call(ResetPasswordParams params) => resetPasswordRepository.resetPassword(params.email, params.token, params.password, params.confirmPassword);

}