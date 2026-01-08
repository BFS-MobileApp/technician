import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/home/data/models/home_model.dart';
import 'package:technician/feature/home/domain/entities/profile.dart';

abstract class HomeRepository {

  Future<Either<Failures , UserInfo>> getUserInfo();

  Future<Either<Failures , HomeModel>> getClaimsCount();

  Future<void> saveUserInfo(String email , String name , String image , String phone , List<String> permissions , int userId , int emailNotification, int maxUploadFiles);
}
