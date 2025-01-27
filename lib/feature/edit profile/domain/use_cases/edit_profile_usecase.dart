import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/edit%20profile/domain/entities/edit_profile_user_info.dart';
import 'package:technician/feature/edit%20profile/domain/repositories/edit_profile_repository.dart';

class EditProfileUseCase implements UseCase<EditProfileUserInfo , NoParams>{

  final EditProfileRepository editProfileRepository;
  EditProfileUseCase({required this.editProfileRepository});

  @override
  Future<Either<Failures, EditProfileUserInfo>> call(NoParams params) => editProfileRepository.getUserInfo();

}