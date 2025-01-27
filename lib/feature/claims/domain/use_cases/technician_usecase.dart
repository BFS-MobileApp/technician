import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/claims/data/models/technician_model.dart';
import 'package:technician/feature/claims/domain/repositories/claims_repository.dart';

class TechnicianUseCase implements UseCase<TechnicianModel , TechniciansParams> {

  final ClaimsRepository claimsRepository;

  TechnicianUseCase({required this.claimsRepository});

  @override
  Future<Either<Failures, TechnicianModel>> call(TechniciansParams params) =>
      claimsRepository.getAllTechnician(params.claimId);
}