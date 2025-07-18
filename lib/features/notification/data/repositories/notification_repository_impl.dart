import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasource/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<NotificationEntity>> getAllNotifications() async {
    final data = await remoteDataSource.getAllNotifications();
    return data.map((json) => NotificationEntity.fromJson(json)).toList();
  }

  @override
  Future<NotificationEntity> getNotificationById(int id) async {
    final json = await remoteDataSource.getNotificationById(id);
    return NotificationEntity.fromJson(json);
  }

  @override
  Future<void> postNotification(NotificationEntity notification) async {
    await remoteDataSource.postNotification(notification.toJson());
  }
}
