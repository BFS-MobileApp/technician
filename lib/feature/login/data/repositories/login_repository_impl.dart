import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:technician/feature/login/data/models/login_model.dart';
import 'package:technician/feature/login/domain/entities/login.dart';

import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {

	final NetworkInfo networkInfo;
  final LoginRemoteDataSource loginRemoteDataSource;

	LoginRepositoryImpl({required this.networkInfo ,required this.loginRemoteDataSource});

  @override
  Future<Either<Failures, Login>> login(String email, String password , bool rememberMe) async{
    if(await networkInfo.isConnected){
      try{
        final response = await loginRemoteDataSource.login(email, password);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final LoginModel model = LoginModel.fromJson(response['data']);
          saveUserInfo(email , model.name , model.token , rememberMe);
          return Right(model);
        } else {
          return Left(ServerFailure(msg: Helper.getCurrentLocal() == 'AR' ? 'invalidCredentials'.tr : response['data']['message']));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<void> saveUserInfo(String email , String name , String token , bool rememberMe) async{
    Prefs.setString(AppStrings.token, token);
    Prefs.setString(AppStrings.userName, name);
    if(rememberMe){
      Prefs.setBool(AppStrings.login, true);
    }
  }
}
