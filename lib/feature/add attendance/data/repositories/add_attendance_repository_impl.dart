import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/feature/add%20attendance/data/data_sources/add_attendance_data_source.dart';
import 'package:technician/feature/add%20attendance/domain/repositories/add_attendance_repository.dart';
import 'package:technician/widgets/message_widget.dart';

class AddAttendanceRepositoryImpl extends AddAttendanceRepository{

  final NetworkInfo networkInfo;
  final AddAttendanceDataSource addAttendanceDataSource;

  AddAttendanceRepositoryImpl({required this.networkInfo ,required this.addAttendanceDataSource});

  @override
  Future<Either<Failures, bool>> checkIn(String longitude, String latitude, String note) async{
    if(await networkInfo.isConnected){
      try{
        final response = await addAttendanceDataSource.checkIn(longitude, latitude, note);
        final int statusCode = response['statusCode'];
        print(response['data']);
        if(statusCode == 200){
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException {
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures, bool>> checkOut(String longitude, String latitude, String note) async{
    if(await networkInfo.isConnected){
      try{
        final response = await addAttendanceDataSource.checkOut(longitude, latitude, note);
        final int statusCode = response['statusCode'];
        print(response['data']);
        if(statusCode == 200){
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.green);
          return const Right(true);
        } else {
          MessageWidget.showSnackBar(response['data']['message'].toString(), AppColors.errorColor);
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException {
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }
}