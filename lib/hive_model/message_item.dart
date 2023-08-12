import 'package:hive_flutter/hive_flutter.dart';

import 'message_role.dart';

part 'message_item.g.dart';

@HiveType(typeId: 1)
class MessageItem extends HiveObject {
  @HiveField(0)
  final String message;
  @HiveField(1)
  final MessageRole role;
  @HiveField(2)
  final DateTime createdAt;

  MessageItem(this.message, this.role, this.createdAt);

  @override
  String toString() =>
      'MessageItem(message: $message, role: $role, createdAt: $createdAt)';
}
