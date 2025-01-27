import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:technician/core/error/exceptions.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/network/network_info.dart';
import 'package:technician/feature/my_attendance/data/data_sources/my_attendance_data_source.dart';
import 'package:technician/feature/my_attendance/data/models/my_attendance_model.dart';
import 'package:technician/feature/my_attendance/domain/repositories/my_attendance_repository.dart';

class MyAttendanceRepositoryImpl extends MyAttendanceRepository{

  final NetworkInfo networkInfo;
  final MyAttendanceDataSource myAttendanceDataSource;

  MyAttendanceRepositoryImpl({required this.networkInfo , required this.myAttendanceDataSource});

  @override
  Future<Either<Failures, MyAttendanceModel>> getAttendance() async{
    if(await networkInfo.isConnected){
      try{
        final response = await myAttendanceDataSource.getAttendance();
        final int statusCode = response['statusCode'];
        if(statusCode == 200){
          final MyAttendanceModel model = MyAttendanceModel.fromJson(response['data']);
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