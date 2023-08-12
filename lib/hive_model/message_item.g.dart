// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageItemAdapter extends TypeAdapter<MessageItem> {
  @override
  final int typeId = 1;

  @override
  MessageItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageItem(
      fields[0] as String,
      fields[1] as MessageRole,
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MessageItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
