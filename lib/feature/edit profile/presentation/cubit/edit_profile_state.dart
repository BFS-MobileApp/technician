import 'package:equatable/equatable.dart';
import 'package:technician/feature/edit%20profile/domain/entities/edit_profile_user_info.dart';

abstract class EditProfileState extends Equatable{
  const EditProfileState();
}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileInitialState extends EditProfileInitial{}

class EditProfileIsLoading extends EditProfileInitial{}

class EditProfileLoaded extends EditProfileInitial{

  final EditProfileUserInfo userInfo;

  EditProfileLoaded({required this.userInfo});

  @override
  List<Object> get props =>[userInfo];
}

class ChangePasswordLoaded extends EditProfileInitial{

  final bool  isPasswordChanged;

  ChangePasswordLoaded({required this.isPasswordChanged});

  @override
  List<Object> get props =>[isPasswordChanged];
}

class UpdateProfileLoaded extends EditProfileInitial{

  final bool isProfileUpdated;

  UpdateProfileLoaded({required this.isProfileUpdated});

  @override
  List<Object> get props =>[isProfileUpdated];
}

class ChangePasswordError extends EditProfileInitial{

  final String msg;
  ChangePasswordError({required this.msg});

  @override
  List<Object> get props =>[msg];
}

class EditProfileError extends EditProfileInitial{
  final String msg;
  EditProfileError({required this.msg});

  @override
  List<Object> get props =>[msg];
}