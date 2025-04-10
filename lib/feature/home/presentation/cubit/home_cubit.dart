import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/claims/data/models/claims_model.dart';
import 'package:technician/feature/claims/domain/use_cases/all_claims_usecase.dart';
import 'package:technician/feature/home/data/models/home_model.dart';
import 'package:technician/feature/home/domain/entities/profile.dart';
import 'package:technician/feature/home/domain/use_cases/claims_usecase.dart';
import 'package:technician/feature/home/domain/use_cases/home_usecase.dart';
import 'package:technician/feature/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState>{

  final HomeUseCase homeUseCase;
  final ClaimsUseCase claimsUseCase;
  final AllClaimsUseCase allClaimsUseCase;
  HomeCubit({required this.homeUseCase  , required this.claimsUseCase , required this.allClaimsUseCase}) : super(HomeInitial());

  void initLoginPage() => emit(HomeInitial());

  Future<void> getUserInfo() async{
    emit(HomeIsLoading());
    Either<Failures , UserInfo> response = await homeUseCase(NoParams());
    emit(response.fold(
            (failures) => HomeError(msg: failures.msg),
            (info) => HomeLoaded(userInfo: info)));
  }

  Future<ClaimsModel?> getStartedClaims(Map<String , dynamic> data) async {
    emit(HomeIsLoading());

    Either<Failures, ClaimsModel> response = await allClaimsUseCase(ClaimsParams(data: data));

    return response.fold(
          (failures) {
        // Log failure case
        print('Failed to load related recipes: ${failures.msg}');
        emit(HomeError(msg: failures.msg));
        return null; // Return null in case of failure
      },
          (info) {
        // Log success case
        print(info.data.length);
        return info; // Return the RelatedChefDetailsModel (info)
      },
    );
  }

  Future<void> getClaimsInfo() async{
    emit(HomeIsLoading());
    Either<Failures , HomeModel> response = await claimsUseCase(NoParams());
    emit(response.fold(
            (failures) => HomeError(msg: failures.msg),
            (model) => ClaimsLoaded(homeModel: model)));
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