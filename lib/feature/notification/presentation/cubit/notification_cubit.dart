import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/feature/notification/data/models/notification_model.dart';
import 'package:technician/feature/notification/domain/use_cases/notificaion_use_case.dart';
import 'package:technician/feature/notification/presentation/cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState>{

  final NotificaionUseCase notificaionUseCase;

  NotificationCubit({required this.notificaionUseCase}) : super(NotificationInitial());

  void initLoginPage() => emit(NotificationInitial());

  Future<void> getNotifications() async{
    emit(NotificationIsLoading());
    Either<Failures , NotificationModel> response = await notificaionUseCase(NoParams());
    emit(response.fold(
            (failures) => NotificationError(error: failures.msg),
            (model) => NotificationLoaded(model: model)));
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