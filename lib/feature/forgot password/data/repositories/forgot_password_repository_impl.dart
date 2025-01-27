import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/feature/forgot%20password/data/data_sources/forgot_password_remote_data_source.dart';
import 'package:technician/feature/forgot%20password/domain/repositories/forgot_password_repository.dart';
import 'package:technician/widgets/message_widget.dart';

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository{

  final NetworkInfo networkInfo;
  final ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;


  ForgotPasswordRepositoryImpl({required this.networkInfo,required this.forgotPasswordRemoteDataSource});

  @override
  Future<Either<Failures, bool>> forgotPassword(String email) async{
    if(await networkInfo.isConnected){
      try{
        final response = await forgotPasswordRemoteDataSource.forgotPassword(email);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          MessageWidget.showSnackBar("emailSentSuccessfully".tr, AppColors.green);
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