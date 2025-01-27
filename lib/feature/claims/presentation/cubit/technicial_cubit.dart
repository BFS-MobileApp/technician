import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/claims/domain/use_cases/technician_usecase.dart';
import 'package:technician/feature/claims/presentation/cubit/technical_state.dart';

import '../../data/models/technician_model.dart';

class TechnicalCubit extends Cubit<TechnicalState>{

  final TechnicianUseCase technicianUseCase;
  TechnicalCubit({required this.technicianUseCase}) : super(TechnicalInitial());

  void initLoginPage() => emit(TechnicalInitial());


  Future<TechnicianModel?> getAllTechnician(String claimId) async {
    emit(TechnicianIsLoading());
    Either<Failures, TechnicianModel> response = await technicianUseCase(TechniciansParams(claimId: claimId));
    return response.fold(
          (failures) {
        // Print the error message if there is a failure
        print("Error: ${failures.msg}");
        emit(TechnicianError(msg: failures.msg));
        return null; // Return null in case of failure
      },
          (info) {
        // Print the model data if successful
        print("TechnicianModel: ${info.toJson()}");
        emit(TechnicianLoaded(model: info));
        return info; // Return the TechnicianModel on success
      },
    );
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