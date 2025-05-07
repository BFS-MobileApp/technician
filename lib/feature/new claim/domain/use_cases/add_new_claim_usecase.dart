import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/new%20claim/domain/entities/add_new_claim.dart';
import 'package:technician/feature/new%20claim/domain/repositories/new_claim_repository.dart';

class AddNewClaimUseCase implements UseCase<AddNewClaim , AddNewClaimParams>{

  final NewClaimRepository newClaimRepository;
  AddNewClaimUseCase({required this.newClaimRepository});

  @override
  Future<Either<Failures, AddNewClaim>> call(AddNewClaimParams params) => newClaimRepository.addNewClaim(params.unitId , params.categoryId , params.subCategoryId , params.claimTypeId , params.description , params.availableTime , params.availableDate,params.file);

}
class UpdateClaimUseCase implements UseCase<AddNewClaim , UpdateClaimParams>{

  final NewClaimRepository newClaimRepository;
  UpdateClaimUseCase({required this.newClaimRepository});

  @override
  Future<Either<Failures, AddNewClaim>> call(UpdateClaimParams params) =>
      newClaimRepository.updateClaim( params.categoryId ,
          params.subCategoryId , params.claimTypeId , params.description ,
          params.availableTime , params.availableDate,
          // params.file
          params.claimId,params.priority);

}