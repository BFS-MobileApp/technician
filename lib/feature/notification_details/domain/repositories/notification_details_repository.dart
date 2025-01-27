import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';

abstract class NotificationDetailsRepository{

  Future<Either<Failures , ClaimDetailsModel>> getClaimDetails(String referenceId);
}