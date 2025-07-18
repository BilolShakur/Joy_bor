class NotificationEntity {
  final int? id;
  final int userId;
  final String title;
  final String message;
  final String notificationType;
  final bool isRead;
  final DateTime? createdAt;
  final NotificationUser? user;

  NotificationEntity({
    this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.notificationType,
    required this.isRead,
    this.createdAt,
    this.user,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'],
      userId: json['user_id'] ?? json['userId'],
      title: json['title'],
      message: json['message'],
      notificationType: json['notification_type'] ?? json['notificationType'],
      isRead: json['is_read'] ?? json['isRead'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      user: json['user'] != null
          ? NotificationUser.fromJson(json['user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'message': message,
      'notification_type': notificationType,
      'is_read': isRead,
      'created_at': createdAt?.toIso8601String(),
      'user': user?.toJson(),
    };
  }
}

class NotificationUser {
  final int id;
  final String fullName;
  final String? email;

  NotificationUser({required this.id, required this.fullName, this.email});

  factory NotificationUser.fromJson(Map<String, dynamic> json) {
    return NotificationUser(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'full_name': fullName, 'email': email};
  }
}
