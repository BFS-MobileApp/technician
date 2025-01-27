import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/feature/reset_password/data/data_sources/reset_password_remote_data_source.dart';
import 'package:technician/feature/reset_password/domain/repositories/reset_password_repository.dart';
import 'package:technician/widgets/message_widget.dart';

class ResetPasswordRepositoryImpl extends ResetPasswordRepository{

  final NetworkInfo networkInfo;
  final ResetPasswordRemoteDataSource resetPasswordRemoteDataSource;


  ResetPasswordRepositoryImpl({required this.networkInfo,required this.resetPasswordRemoteDataSource});

  @override
  Future<Either<Failures, bool>> resetPassword(String email, String token, String password, String confirmPassword) async{
    if(await networkInfo.isConnected){
      try{
        final response = await resetPasswordRemoteDataSource.resetPassword(email, token, password, confirmPassword);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
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


}