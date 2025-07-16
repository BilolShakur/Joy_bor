import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getAllNotifications();
  Future<NotificationEntity> getNotificationById(int id);
  Future<void> postNotification(NotificationEntity notification);
}
