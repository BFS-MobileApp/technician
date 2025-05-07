import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/data/models/material_model.dart';
import 'package:technician/feature/claim%20details/domain/repositories/claims_details_repository.dart';

class MaterialUseCase implements UseCase<MaterialResponse , ClaimsDetailsParams> {

  final ClaimsDetailsRepository claimsDetailsRepository;

  MaterialUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, MaterialResponse>> call(ClaimsDetailsParams params) =>
      claimsDetailsRepository.getMaterial(params.referenceId,params.page,params.search);
}
class DeleteMaterialUseCase implements UseCase<bool, String> {
  final ClaimsDetailsRepository claimsDetailsRepository;

  DeleteMaterialUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(String materialId) {
    return claimsDetailsRepository.deleteMaterial(materialId);
  }
}
class DeleteClaimUseCase implements UseCase<bool, String> {
  final ClaimsDetailsRepository claimsDetailsRepository;

  DeleteClaimUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(String claimId) {
    return claimsDetailsRepository.deleteClaim(claimId);
  }
}
class EditMaterialQuantityUseCase implements UseCase<bool, EditMaterialParams> {
  final ClaimsDetailsRepository claimsDetailsRepository;

  EditMaterialQuantityUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(EditMaterialParams params) {
    return claimsDetailsRepository.editMaterialQuantity(params.id, params.quantity);
  }
}
class AddMaterialUseCase implements UseCase<bool, AddMaterialParams> {
  final ClaimsDetailsRepository claimsDetailsRepository;

  AddMaterialUseCase({required this.claimsDetailsRepository});

  @override
  Future<Either<Failures, bool>> call(AddMaterialParams params) {
    return claimsDetailsRepository.addMaterial(params);
  }
}


