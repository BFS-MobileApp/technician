import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/new%20claim/data/models/avaliable_time_model.dart';
import 'package:technician/feature/new%20claim/data/models/building_model.dart';
import 'package:technician/feature/new%20claim/data/models/category_model.dart';
import 'package:technician/feature/new%20claim/data/models/claim_type_model.dart';
import 'package:technician/feature/new%20claim/data/models/unit_model.dart';
import 'package:technician/feature/new%20claim/domain/entities/add_new_claim.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/add_new_claim_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/available_times_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/buildings_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/category_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/claims_type_usecase.dart';
import 'package:technician/feature/new%20claim/domain/use_cases/unit_usecase.dart';
import 'package:technician/feature/new%20claim/presentation/cubit/new_claim_state.dart';

class NewClaimCubit extends Cubit<NewClaimState>{

  final BuildingsUseCase buildingsUseCase;
  final UnitUseCase unitUseCase;
  final CategoryUseCase categoryUseCase;
  final ClaimsTypeUseCase claimsTypeUseCase;
  final AvailableTimesUseCase availableTimesUseCase;
  final AddNewClaimUseCase addNewClaimUseCase;

  NewClaimCubit({required this.buildingsUseCase , required this.unitUseCase , required this.categoryUseCase , required this.claimsTypeUseCase , required this.availableTimesUseCase , required this.addNewClaimUseCase}) : super(NewClaimInitial());

  void initLoginPage() => emit(NewClaimInitial());

  Future<void> getBuildings() async{
    emit(NewClaimIsLoading());
    Either<Failures , BuildingModel> response = await buildingsUseCase(NoParams());
    emit(response.fold(
            (failures) => NewClaimError(msg: failures.msg),
            (model) => BuildingsLoaded(buildingModel: model)));
  }

  Future<void> getUnits(String buildingId) async{
    emit(NewClaimIsLoading());
    Either<Failures , UnitModel> response = await unitUseCase(UnitParams(buildingId: buildingId));
    emit(response.fold(
            (failures) => NewClaimError(msg: failures.msg),
            (model) => UnitLoaded(unitModel: model)));
  }

  Future<void> getCategories(String unitId) async{
    emit(NewClaimIsLoading());
    Either<Failures , CategoryModel> response = await categoryUseCase(CategoryParams(unitId: unitId));
    emit(response.fold(
            (failures) => NewClaimError(msg: failures.msg),
            (model) => CategoryLoaded(categoryModel: model)));
  }

  Future<void> getClaimsType(String subCategoryId) async{
    emit(NewClaimIsLoading());
    Either<Failures , ClaimsTypeModel> response = await claimsTypeUseCase(ClaimsTypeParams(subCategoryId: subCategoryId));
    emit(response.fold(
            (failures) => NewClaimError(msg: failures.msg),
            (model) => ClaimsTypeLoaded(claimsTypeModel: model)));
  }

  Future<void> getAvailableTimes(String companyId) async{
    emit(NewClaimIsLoading());
    Either<Failures , AvailableTimeModel> response = await availableTimesUseCase(AvailableTimesParams(companyId: companyId));
    emit(response.fold(
            (failures) => NewClaimError(msg: failures.msg),
            (model) => AvailableTimesLoaded(availableTimeModel: model)));
  }

  Future<void> addNewClaim(String unitId , String categoryId , String subCategoryId , String claimTypeId, String description , String availableTime , String availableDate) async{
    emit(NewClaimIsLoading());
    Either<Failures , AddNewClaim> response = await addNewClaimUseCase(AddNewClaimParams(unitId: unitId , categoryId: categoryId , subCategoryId: subCategoryId , claimTypeId: claimTypeId , description: description , availableTime:  availableTime, availableDate: availableDate));
    emit(response.fold(
            (failures) => NewClaimError(msg: failures.msg),
            (model) => AddNewClaimLoaded(addNewClaim: model)));
  }

  String mapFailureToMsg(Failures failures){
    switch (failures.runtimeType){
      case const (ServerFailure):
        return AppStrings.serverError;
      case const (CashFailure):
        return AppStrings.cacheError;
      default:
        return AppStrings.unexpectedError;
    }
  }

}