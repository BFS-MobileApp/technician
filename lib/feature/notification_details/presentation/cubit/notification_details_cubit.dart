import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/notification_details/domain/use_cases/notification_details_use_case.dart';
import 'package:technician/feature/notification_details/presentation/cubit/notification_details_state.dart';

class NotificationDetailsCubit extends Cubit<NotificationDetailsState>{

  final NotificationDetailsUseCase notificationDetailsUseCase;

  NotificationDetailsCubit({required this.notificationDetailsUseCase}) : super(NotificationDetailsInitial());

  void initLoginPage() => emit(NotificationDetailsInitial());

  Future<void> getNotificationDetails(String referenceId) async{
    emit(NotificationDetailsIsLoading());
    Either<Failures , ClaimDetailsModel> response = await notificationDetailsUseCase(ClaimsDetailsParams(referenceId: referenceId, page: 0));
    emit(response.fold(
            (failures) => NotificationDetailsError(error: failures.msg),
            (model) => NotificationDetailsLoaded(model: model)));
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