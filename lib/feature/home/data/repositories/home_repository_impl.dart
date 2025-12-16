import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/home/data/data_sources/home_remote_data_source.dart';
import 'package:technician/feature/home/data/models/home_model.dart';
import 'package:technician/feature/home/data/models/profile_model.dart';
import 'package:technician/feature/home/domain/entities/profile.dart';
import 'package:technician/feature/home/domain/repositories/home_repository.dart';


class HomeRepositoryImpl extends HomeRepository {

  final NetworkInfo networkInfo;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl({required this.networkInfo ,required this.homeRemoteDataSource});

  @override
  Future<Either<Failures, UserInfo>> getUserInfo() async {
    print("🔍 getUserInfo() CALLED");

    if (await networkInfo.isConnected) {
      print("📡 Network Connected");

      try {
        print("➡️ Calling homeRemoteDataSource.getUserInfo()");
        final response = await homeRemoteDataSource.getUserInfo();

        print("📥 Raw Response: $response");

        final int statusCode = response['statusCode'];
        print("🔢 Status Code: $statusCode");

        if (statusCode == 200) {
          print("✅ Success 200 - Parsing ProfileModel");

          final ProfileModel model = ProfileModel.fromJson(response['data']);
          print("👤 Parsed Model: $model");
          print("📧 Email: ${model.email}");
          print("📱 Mobile: ${model.mobile}");
          print("🎫 Permissions: ${model.permissions}");
          print("🧿 FCM Token on server: ${model.fcmToken}");

          saveUserInfo(
            model.email,
            model.name,
            model.image,
            model.mobile,
            model.permissions,
            model.id,
            model.emailNotification,
          );

          String? token = await FirebaseMessaging.instance.getToken();

          if (token != model.fcmToken) {
            await homeRemoteDataSource.setFcmToken();
          } else {
          }

          return Right(model);

        } else {

          final String errorMsg = response['data']['error'] ?? 'error'.tr;
          return Left(ServerFailure(msg: errorMsg));
        }

      } on ServerException catch (e) {
        return Left(ServerFailure(msg: e.message ?? "Server Error"));
      } catch (e, stack) {
        return Left(ServerFailure(msg: 'error'.tr));
      }

    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }



  @override
  Future<void> saveUserInfo(String email, String name, String image, String phone, List<String> permissions , int userId , int emailNotification) async{
    Prefs.setString(AppStrings.email, email);
    Prefs.setString(AppStrings.userName, name);
    Prefs.setString(AppStrings.image, image);
    Prefs.setString(AppStrings.phone, phone);
    Prefs.setInt(AppStrings.userId, userId);
    Prefs.setStringList(AppStrings.permissions, permissions);
    Prefs.setInt(AppStrings.emailNotification, emailNotification);

  }

  @override
  Future<Either<Failures, HomeModel>> getClaimsCount() async{
    if(await networkInfo.isConnected){
      try{
        final response = await homeRemoteDataSource.getClaimsCount();
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final HomeModel model = HomeModel.fromJson(response['data']);
          return Right(model);
        } else {
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }
}
