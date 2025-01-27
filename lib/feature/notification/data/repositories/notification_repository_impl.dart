import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/feature/notification/data/data_sources/notification_remote_data_source.dart';
import 'package:technician/feature/notification/data/models/notification_model.dart';
import 'package:technician/feature/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository{

  NotificationRemoteDataSource notificationRemoteDataSource;
  final NetworkInfo networkInfo;


  NotificationRepositoryImpl({required this.notificationRemoteDataSource,required this.networkInfo});

  @override
  Future<Either<Failures, NotificationModel>> getNotifications() async{
    if(await networkInfo.isConnected){
      try{
        final response = await notificationRemoteDataSource.getNotifications();
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final NotificationModel model = NotificationModel.fromJson(response['data']);
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