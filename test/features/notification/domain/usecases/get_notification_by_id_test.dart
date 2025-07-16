import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:joy_bor/features/notification/domain/entities/notification_entity.dart';
import 'package:joy_bor/features/notification/domain/repositories/notification_repository.dart';
import 'package:joy_bor/features/notification/domain/usecases/get_notification_by_id.dart';

class MockNotificationRepository extends Mock
    implements NotificationRepository {
  @override
  Future<List<NotificationEntity>> getAllNotifications() =>
      (super.noSuchMethod(
            Invocation.method(#getAllNotifications, []),
            returnValue: Future.value(<NotificationEntity>[]),
          )
          as Future<List<NotificationEntity>>);
  @override
  Future<NotificationEntity> getNotificationById(int id) =>
      (super.noSuchMethod(
            Invocation.method(#getNotificationById, [id]),
            returnValue: Future.value(
              NotificationEntity(
                id: 0,
                userId: 0,
                title: '',
                message: '',
                notificationType: '',
                isRead: false,
              ),
            ),
          )
          as Future<NotificationEntity>);
  @override
  Future<void> postNotification(NotificationEntity notification) =>
      (super.noSuchMethod(
            Invocation.method(#postNotification, [notification]),
            returnValue: Future.value(),
          )
          as Future<void>);
}

void main() {
  late GetNotificationById usecase;
  late MockNotificationRepository mockRepository;

  setUp(() {
    mockRepository = MockNotificationRepository();
    usecase = GetNotificationById(mockRepository);
  });

  test('should get notification by id from the repository', () async {
    // arrange
    final notification = NotificationEntity(
      id: 1,
      userId: 1,
      title: 'Test',
      message: 'Test message',
      notificationType: 'info',
      isRead: false,
      createdAt: DateTime.now(),
    );
    when(
      mockRepository.getNotificationById(1),
    ).thenAnswer((_) async => notification);

    // act
    final result = await usecase(1);

    // assert
    expect(result, notification);
    verify(mockRepository.getNotificationById(1));
    verifyNoMoreInteractions(mockRepository);
  });
}
