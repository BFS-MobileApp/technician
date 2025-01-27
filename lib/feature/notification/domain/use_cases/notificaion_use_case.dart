import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/core/usecase/use_case.dart';
import 'package:technician/feature/notification/data/models/notification_model.dart';
import 'package:technician/feature/notification/domain/repositories/notification_repository.dart';

class NotificaionUseCase implements UseCase<NotificationModel , NoParams>{

  final NotificationRepository notificationRepository;
  NotificaionUseCase({required this.notificationRepository});

  @override
  Future<Either<Failures, NotificationModel>> call(NoParams params) => notificationRepository.getNotifications();

}