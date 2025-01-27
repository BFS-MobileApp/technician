import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/new%20claim/data/models/avaliable_time_model.dart';

import '../repositories/new_claim_repository.dart';

class AvailableTimesUseCase implements UseCase<AvailableTimeModel , AvailableTimesParams>{

  final NewClaimRepository newClaimRepository;
  AvailableTimesUseCase({required this.newClaimRepository});

  @override
  Future<Either<Failures, AvailableTimeModel>> call(AvailableTimesParams params) => newClaimRepository.getAvailableTimes(params.companyId);

}