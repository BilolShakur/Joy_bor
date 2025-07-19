import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_state.dart';
import '../../domain/entities/notification_entity.dart';
import '../widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  Map<String, List<NotificationEntity>> groupByDate(
    List<NotificationEntity> notifications,
  ) {
    final Map<String, List<NotificationEntity>> grouped = {};
    for (var notif in notifications) {
      final date = notif.createdAt != null
          ? "${notif.createdAt!.year}-${notif.createdAt!.month.toString().padLeft(2, '0')}-${notif.createdAt!.day.toString().padLeft(2, '0')}"
          : "Unknown";
      grouped.putIfAbsent(date, () => []).add(notif);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            final grouped = groupByDate(state.notifications);
            return ListView(
              children: grouped.entries.map((entry) {
                return _buildSection(entry.key, entry.value);
              }).toList(),
            );
          } else if (state is NotificationError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildSection(String title, List<NotificationEntity> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...notifications.asMap().entries.map((entry) {
          final index = entry.key;
          final notification = entry.value;
          return Column(
            children: [
              _buildNotificationItem(notification),
              if (index < notifications.length - 1)
                Container(
                  margin: const EdgeInsets.only(left: 76, right: 20, top: 8),
                  height: 1,
                  color: Colors.white.withOpacity(0.1),
                ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildNotificationItem(NotificationEntity notification) {
    return NotificationItem(notification: notification);
  }
}
