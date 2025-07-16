import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:joy_bor/features/notification/data/datasource/notification_remote_datasource.dart';
import 'package:joy_bor/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:joy_bor/features/notification/domain/entities/notification_entity.dart';

class MockNotificationRemoteDataSource extends Mock
    implements NotificationRemoteDataSource {
  @override
  Future<List<Map<String, dynamic>>> getAllNotifications() =>
      (super.noSuchMethod(
            Invocation.method(#getAllNotifications, []),
            returnValue: Future.value(<Map<String, dynamic>>[]),
          )
          as Future<List<Map<String, dynamic>>>);
  @override
  Future<Map<String, dynamic>> getNotificationById(int id) =>
      (super.noSuchMethod(
            Invocation.method(#getNotificationById, [id]),
            returnValue: Future.value(<String, dynamic>{}),
          )
          as Future<Map<String, dynamic>>);
  @override
  Future<void> postNotification(Map<String, dynamic> notification) =>
      (super.noSuchMethod(
            Invocation.method(#postNotification, [notification]),
            returnValue: Future.value(),
          )
          as Future<void>);
}

void main() {
  late NotificationRepositoryImpl repository;
  late MockNotificationRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockNotificationRemoteDataSource();
    repository = NotificationRepositoryImpl(mockRemoteDataSource);
  });

  test(
    'should return list of NotificationEntity from remote data source',
    () async {
      // arrange
      final notificationJson = {
        'id': 1,
        'user_id': 1,
        'title': 'Test',
        'message': 'Test message',
        'notification_type': 'info',
        'is_read': false,
        'created_at': DateTime.now().toIso8601String(),
        'user': null,
      };
      when(
        mockRemoteDataSource.getAllNotifications(),
      ).thenAnswer((_) async => [notificationJson]);

      // act
      final result = await repository.getAllNotifications();

      // assert
      expect(result, isA<List<NotificationEntity>>());
      expect(result.first.title, 'Test');
      verify(mockRemoteDataSource.getAllNotifications());
      verifyNoMoreInteractions(mockRemoteDataSource);
    },
  );
}
