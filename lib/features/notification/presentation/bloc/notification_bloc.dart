import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_notifications.dart';
import '../../domain/usecases/get_notification_by_id.dart';
import '../../domain/usecases/post_notification.dart';
import '../../domain/entities/notification_entity.dart';
import 'notification_event.dart';
import 'notification_state.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetAllNotifications getAllNotifications;
  final GetNotificationById getNotificationById;
  final PostNotification postNotification;
  final FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  NotificationBloc({
    required this.getAllNotifications,
    required this.getNotificationById,
    required this.postNotification,
    this.flutterLocalNotificationsPlugin,
  }) : super(NotificationInitial()) {
    on<FetchAllNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notifications = await getAllNotifications();
        emit(NotificationLoaded(notifications));

        if (flutterLocalNotificationsPlugin != null &&
            notifications.isNotEmpty) {
          final latest = notifications.first;
          await flutterLocalNotificationsPlugin!.show(
            latest.id ?? 0,
            latest.title,
            latest.message,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'default_channel',
                'Notifications',
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
        }
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });

    on<FetchNotificationById>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notification = await getNotificationById(event.id);
        emit(NotificationDetailLoaded(notification));
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });

    on<PostNotificationEvent>((event, emit) async {
      emit(NotificationLoading());
      try {
        await postNotification(event.notification);
        // Show local notification immediately after posting
        if (flutterLocalNotificationsPlugin != null) {
          await flutterLocalNotificationsPlugin!.show(
            event.notification.id ?? 0,
            event.notification.title,
            event.notification.message,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'default_channel',
                'Notifications',
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
        }
        add(FetchAllNotifications());
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });
  }
}
