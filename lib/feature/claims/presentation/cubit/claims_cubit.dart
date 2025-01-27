import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/claims/data/models/claims_model.dart';
import 'package:technician/feature/claims/domain/use_cases/all_claims_usecase.dart';
import 'package:technician/feature/claims/domain/use_cases/technician_usecase.dart';
import 'package:technician/feature/claims/presentation/cubit/claims_state.dart';

class ClaimsCubit extends Cubit<ClaimsState>{

  final AllClaimsUseCase allClaimsUseCase;
  final TechnicianUseCase technicianUseCase;
  ClaimsCubit({required this.allClaimsUseCase , required this.technicianUseCase}) : super(ClaimsInitial());

  void initLoginPage() => emit(ClaimsInitial());

  Future<void> getAllClaims(Map<String , dynamic> data) async{
    emit(ClaimsIsLoading());
    Either<Failures , ClaimsModel> response = await allClaimsUseCase(ClaimsParams(data: data));
    emit(response.fold(
            (failures) => ClaimsError(msg: failures.msg),
            (info) => ClaimsLoaded(model: info)));
  }

  Future<ClaimsModel?> getStartedClaims(Map<String , dynamic> data) async {
    emit(ClaimsIsLoading());

    // Log when the request starts

    Either<Failures, ClaimsModel> response = await allClaimsUseCase(ClaimsParams(data: data));

    // Emit the appropriate state based on the response
    return response.fold(
          (failures) {
        // Log failure case
        print('Failed to load related recipes: ${failures.msg}');
        emit(ClaimsError(msg: failures.msg));
        return null; // Return null in case of failure
      },
          (info) {
        // Log success case
        print(info.data.length);
        emit(ClaimsLoaded(model: info));
        return info; // Return the RelatedChefDetailsModel (info)
      },
    );
  }

  Future<void> resetAllClaims(ClaimsModel claimsModel) async{
    emit(ClaimsLoaded(model: claimsModel));
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