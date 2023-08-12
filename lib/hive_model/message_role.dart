import 'package:hive_flutter/hive_flutter.dart';

part 'message_role.g.dart';

@HiveType(typeId: 2)
enum MessageRole {
  @HiveField(0)
  ai,
  @HiveField(1)
  user
}
