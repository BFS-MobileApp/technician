import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/edit%20profile/domain/repositories/edit_profile_repository.dart';

class ChangePasswordUseCase implements UseCase<bool , ChangePasswordParams>{

  final EditProfileRepository editProfileRepository;
  ChangePasswordUseCase({required this.editProfileRepository});

  @override
  Future<Either<Failures, bool>> call(ChangePasswordParams params) => editProfileRepository.changePassword(params.oldPassword, params.password, params.confirmPassword);

}