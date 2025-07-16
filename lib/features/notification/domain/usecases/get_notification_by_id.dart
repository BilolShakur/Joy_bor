import '../repositories/notification_repository.dart';
import '../entities/notification_entity.dart';

class GetNotificationById {
  final NotificationRepository repository;

  GetNotificationById(this.repository);

  Future<NotificationEntity> call(int id) async {
    return await repository.getNotificationById(id);
  }
}
