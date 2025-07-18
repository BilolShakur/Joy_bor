import '../../domain/entities/notification_entity.dart';

abstract class NotificationEvent {}

class FetchAllNotifications extends NotificationEvent {}

class FetchNotificationById extends NotificationEvent {
  final int id;
  FetchNotificationById(this.id);
}

class PostNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;
  PostNotificationEvent(this.notification);
}
