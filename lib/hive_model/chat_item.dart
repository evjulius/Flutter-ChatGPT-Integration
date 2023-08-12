import 'package:hive/hive.dart';

part 'chat_item.g.dart';

@HiveType(typeId: 0)
class ChatItem extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  HiveList messages;

  ChatItem(this.title, this.messages);
}
