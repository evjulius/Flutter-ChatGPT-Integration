// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatItemAdapter extends TypeAdapter<ChatItem> {
  @override
  final int typeId = 0;

  @override
  ChatItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatItem(
      fields[0] as String,
      (fields[1] as HiveList).castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, ChatItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
