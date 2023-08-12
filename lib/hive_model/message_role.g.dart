// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_role.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageRoleAdapter extends TypeAdapter<MessageRole> {
  @override
  final int typeId = 2;

  @override
  MessageRole read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MessageRole.ai;
      case 1:
        return MessageRole.user;
      default:
        return MessageRole.ai;
    }
  }

  @override
  void write(BinaryWriter writer, MessageRole obj) {
    switch (obj) {
      case MessageRole.ai:
        writer.writeByte(0);
        break;
      case MessageRole.user:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageRoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
