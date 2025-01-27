import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

class AssignClaimUseCase implements UseCase<bool , AssignClaimParams>{

  final ClaimsDetailsRepository claimsDetailsRepository;
  AssignClaimUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(AssignClaimParams params) => claimsDetailsRepository.assignClaim(params.claimId , params.employeeId , params.startDate , params.endDate);

}