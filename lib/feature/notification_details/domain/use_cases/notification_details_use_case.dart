import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/notification_details/domain/repositories/notification_details_repository.dart';

class NotificationDetailsUseCase implements UseCase<ClaimDetailsModel , ClaimsDetailsParams>{

  final NotificationDetailsRepository notificationDetailsRepository;
  NotificationDetailsUseCase({required this.notificationDetailsRepository});

  @override
  Future<Either<Failures, ClaimDetailsModel>> call(ClaimsDetailsParams params) => notificationDetailsRepository.getClaimDetails(params.referenceId);

}