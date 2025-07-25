import '../../domain/entities/notification_entity.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  NotificationLoaded(this.notifications);
}

class NotificationDetailLoaded extends NotificationState {
  final NotificationEntity notification;
  NotificationDetailLoaded(this.notification);
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}
