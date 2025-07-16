import '../repositories/notification_repository.dart';
import '../entities/notification_entity.dart';

class GetAllNotifications {
  final NotificationRepository repository;

  GetAllNotifications(this.repository);

  Future<List<NotificationEntity>> call() async {
    return await repository.getAllNotifications();
  }
} 