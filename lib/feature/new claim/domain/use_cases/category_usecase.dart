import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/new%20claim/data/models/category_model.dart';

import '../../../../core/usecase/use_case.dart';
import '../repositories/new_claim_repository.dart';

class CategoryUseCase implements UseCase<CategoryModel , CategoryParams>{

  final NewClaimRepository newClaimRepository;
  CategoryUseCase({required this.newClaimRepository});

  @override
  Future<Either<Failures, CategoryModel>> call(CategoryParams params) => newClaimRepository.getCategories(params.unitId);

}