import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/edit%20profile/domain/repositories/edit_profile_repository.dart';

class UpdateProfileUseCase implements UseCase<bool , UpdateProfileParams>{

  final EditProfileRepository editProfileRepository;
  UpdateProfileUseCase({required this.editProfileRepository});

  @override
  Future<Either<Failures, bool>> call(UpdateProfileParams params) => editProfileRepository.updateProfile(params.name, params.mobile, params.imageFile, params.emailNotification);

}