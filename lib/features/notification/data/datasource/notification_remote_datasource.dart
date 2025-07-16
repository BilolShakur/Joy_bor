abstract class NotificationRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllNotifications();
  Future<Map<String, dynamic>> getNotificationById(int id);
  Future<void> postNotification(Map<String, dynamic> notification);
}
