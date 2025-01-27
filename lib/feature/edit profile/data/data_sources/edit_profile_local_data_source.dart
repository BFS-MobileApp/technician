import 'dart:io';

import 'package:technician/feature/edit%20profile/domain/entities/edit_profile_user_info.dart';

abstract class EditProfileLocalDataSource {

  Future<EditProfileUserInfo> getUserInfo();

  Future<Map<String , dynamic>> changePassword(String oldPassword , String password , String confirmPassword);

  Future<Map<String , dynamic>> updateProfile(String name , String mobile , File imageFile , int emailNotification);

}