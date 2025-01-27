import 'dart:io';

import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/api/end_points.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/edit%20profile/data/data_sources/edit_profile_local_data_source.dart';
import 'package:technician/feature/edit%20profile/domain/entities/edit_profile_user_info.dart';

class EditProfileLocalDataSourceImpl extends EditProfileLocalDataSource{

  ApiConsumer consumer;

  EditProfileLocalDataSourceImpl({required this.consumer});

  @override
  Future<EditProfileUserInfo> getUserInfo() {
    String name = Prefs.getString(AppStrings.userName);
    String email = Prefs.getString(AppStrings.email);
    String image = Prefs.getString(AppStrings.image);
    String phone = Prefs.getString(AppStrings.phone);
    int emailNotification = Prefs.getInt(AppStrings.emailNotification);
    EditProfileUserInfo userInfo = EditProfileUserInfo(name: name, email: email, image: image , phone: phone ,emailNotification: emailNotification );
    return Future.value(userInfo);
  }

  @override
  Future<Map<String, dynamic>> changePassword(String oldPassword, String password, String confirmPassword) async{
    final data = {
      "old_password":oldPassword,
      "password":password,
      "password_confirmation":confirmPassword
    };
    final res = await consumer.post(EndPoints.changePassword , queryParams: data);
    return res;
  }

  @override
  Future<Map<String, dynamic>> updateProfile(String name, String mobile, File imageFile , int emailNotification) async{
    Map<String , dynamic> imageFileData = {};
    Map<String , dynamic> data = {
      'name':name,
      'mobile':mobile,
      'email_notifications': emailNotification
    };
    if(imageFile.path != ''){
      imageFileData = {
        'image':imageFile
      };
    }
    final res = await consumer.postFile(EndPoints.updateProfile , queryParams: data , files: imageFileData);
    return res;
  }
}