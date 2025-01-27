import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

class ChangePriorityUseCase implements UseCase<bool , ChangePriorityParams>{

  final ClaimsDetailsRepository claimsDetailsRepository;
  ChangePriorityUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(ChangePriorityParams params) => claimsDetailsRepository.changePriority(params.claimId , params.priority);

}