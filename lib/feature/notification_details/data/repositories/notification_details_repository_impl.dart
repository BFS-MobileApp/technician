import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/notification_details/data/data_sources/notification_details_remote_data_source.dart';
import 'package:technician/feature/notification_details/domain/repositories/notification_details_repository.dart';

class NotificationDetailsRepositoryImpl extends NotificationDetailsRepository{

  final NetworkInfo networkInfo;
  final NotificationDetailsRemoteDataSource notificationDetailsRemoteDataSource;


  NotificationDetailsRepositoryImpl({required this.networkInfo , required this.notificationDetailsRemoteDataSource});

  @override
  Future<Either<Failures, ClaimDetailsModel>> getClaimDetails(String referenceId) async{
    if(await networkInfo.isConnected){
      try{
        final response = await notificationDetailsRemoteDataSource.getNotificationsDetails(referenceId);
        print(response['data']);
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final ClaimDetailsModel claims = ClaimDetailsModel.fromJson(response['data']);
          return Right(claims);
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