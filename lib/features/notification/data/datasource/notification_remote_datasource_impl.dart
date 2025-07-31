import 'package:dio/dio.dart';
import 'notification_remote_datasource.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'http://13.232.21.244:3001/api';

  NotificationRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Map<String, dynamic>>> getAllNotifications() async {
    final response = await dio.get('$baseUrl/notifications');
    return List<Map<String, dynamic>>.from(response.data);
  }

  @override
  Future<Map<String, dynamic>> getNotificationById(int id) async {
    final response = await dio.get('$baseUrl/notifications/$id');
    return Map<String, dynamic>.from(response.data);
  }

  @override
  Future<void> postNotification(Map<String, dynamic> notification) async {
    await dio.post('$baseUrl/notifications', data: notification);
  }
}
