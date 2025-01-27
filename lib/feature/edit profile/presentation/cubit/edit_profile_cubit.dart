import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/edit%20profile/domain/entities/edit_profile_user_info.dart';
import 'package:technician/feature/edit%20profile/domain/use_cases/change_password_usecase.dart';
import 'package:technician/feature/edit%20profile/domain/use_cases/edit_profile_usecase.dart';
import 'package:technician/feature/edit%20profile/domain/use_cases/update_profile_usecase.dart';
import 'package:technician/feature/edit%20profile/presentation/cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState>{

  final EditProfileUseCase editProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  EditProfileCubit({required this.editProfileUseCase , required this.changePasswordUseCase , required this.updateProfileUseCase}) : super(EditProfileInitial());

  void initLoginPage() => emit(EditProfileInitial());

  Future<void> getUserInfo() async{
    emit(EditProfileIsLoading());
    Either<Failures , EditProfileUserInfo> response = await editProfileUseCase(NoParams());
    emit(response.fold(
            (failures) => EditProfileError(msg: failures.msg),
            (info) => EditProfileLoaded(userInfo: info)));
  }

  Future<bool> updateProfile(String name , String mobile , File imageFile , int emailNotification) async{
    emit(EditProfileIsLoading());
    Either<Failures , bool> response = await updateProfileUseCase(UpdateProfileParams(name: name, mobile: mobile, imageFile: imageFile, emailNotification: emailNotification));
    return response.fold(
          (failures) {
        emit(ChangePasswordError(msg: failures.msg));
        return false;
      },
          (info) {
        emit(UpdateProfileLoaded(isProfileUpdated: info));
        return true;
      },
    );
  }

  Future<bool> changePassword(String oldPassword , String password , String confirmPassword) async{
    Either<Failures , bool> response = await changePasswordUseCase(ChangePasswordParams(oldPassword: oldPassword, password: password, confirmPassword: confirmPassword));
    return response.fold(
          (failures) {
        emit(ChangePasswordError(msg: failures.msg));
        return false;
      },
          (info) {
        emit(ChangePasswordLoaded(isPasswordChanged: info));
        return true;
      },
    );
  }

  String mapFailureToMsg(Failures failures){
    switch (failures.runtimeType){
      case const (ServerFailure):
        return AppStrings.serverError;
      case const (CashFailure):
        return AppStrings.cacheError;
      default:
        return AppStrings.unexpectedError;
    }
  }

}