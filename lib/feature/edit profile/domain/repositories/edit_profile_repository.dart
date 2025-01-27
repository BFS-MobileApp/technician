import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/edit%20profile/domain/entities/edit_profile_user_info.dart';

abstract class EditProfileRepository {

  Future<Either<Failures , EditProfileUserInfo>>  getUserInfo();

  Future<Either<Failures , bool>> changePassword(String oldPassword , String password , String confirmPassword);

  Future<Either<Failures , bool>> updateProfile(String name , String mobile , File imageFile , int emailNotification);

  Future<void> updateUserInfo(String name , String mobile , String image);

}