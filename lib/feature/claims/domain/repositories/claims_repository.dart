import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/claims/data/models/claims_model.dart';
import 'package:technician/feature/claims/data/models/technician_model.dart';

abstract class ClaimsRepository {

  Future<Either<Failures , ClaimsModel>> getAllClaims(Map<String, dynamic> data);

  Future<Either<Failures , TechnicianModel>> getAllTechnician(String claimId);

}