import '../repositories/notification_repository.dart';
import '../entities/notification_entity.dart';

class PostNotification {
  final NotificationRepository repository;

  PostNotification(this.repository);

  Future<void> call(NotificationEntity notification) async {
    await repository.postNotification(notification);
  }
}
