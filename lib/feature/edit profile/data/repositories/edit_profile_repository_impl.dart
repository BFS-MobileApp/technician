import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/edit%20profile/data/data_sources/edit_profile_local_data_source.dart';
import 'package:technician/feature/edit%20profile/domain/entities/edit_profile_user_info.dart';
import 'package:technician/feature/edit%20profile/domain/repositories/edit_profile_repository.dart';
import 'package:technician/widgets/message_widget.dart';

class EditProfileRepositoryImpl extends EditProfileRepository{

  final NetworkInfo networkInfo;
  final EditProfileLocalDataSource editProfileLocalDataSource;


  EditProfileRepositoryImpl({required this.editProfileLocalDataSource , required this.networkInfo});

  @override
  Future<Either<Failures, EditProfileUserInfo>> getUserInfo() async{
    try {
      final data = await editProfileLocalDataSource.getUserInfo();
      return Right(data);
    } on FetchDataException {
      return Left(ServerFailure(msg: 'error'.tr));
    }
  }

  @override
  Future<Either<Failures, bool>> changePassword(String oldPassword, String password, String confirmPassword) async{
    if(await networkInfo.isConnected){
      try{
        final response = await editProfileLocalDataSource.changePassword(oldPassword , password , confirmPassword);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          print(response['data']);
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures, bool>> updateProfile(String name, String mobile, File imageFile , int emailNotification) async{
    if(await networkInfo.isConnected){
      try{
        final response = await editProfileLocalDataSource.updateProfile(name, mobile, imageFile, emailNotification);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          print(response['data']);
          final String updatedName = response['data']['name'] ?? name;
           String updatedAvatar = '';
           if( response['data']['avatar'] != null) updatedAvatar = response['data']['avatar'];
          updateUserInfo(updatedName, mobile, updatedAvatar);
          MessageWidget.showSnackBar('profileUpdatedSuccessfully'.tr, AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<void> updateUserInfo(String name, String mobile, String image) async{
    print(image);
    Prefs.setString(AppStrings.userName, name);
    Prefs.setString(AppStrings.image, image);
    Prefs.setString(AppStrings.phone, mobile);
  }
}