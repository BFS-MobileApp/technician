import 'package:dartz/dartz.dart';
import 'package:technician/core/error/failures.dart';
import 'package:technician/feature/notification/data/models/notification_model.dart';

abstract class NotificationRepository{

  Future<Either<Failures , NotificationModel>> getNotifications();
}