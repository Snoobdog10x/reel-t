// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationAdapter extends TypeAdapter<Conversation> {
  @override
  final int typeId = 0;

  @override
  Conversation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conversation(
      id: fields[0] as String?,
      userIds: (fields[1] as List?)?.cast<String>(),
      messages: (fields[2] as List?)?.cast<Message>(),
      secondUser: (fields[3] as List?)?.cast<UserProfile>(),
      latestMessage: fields[4] as String?,
      isMute: fields[5] as bool?,
      isDeleted: fields[6] as bool?,
      createAt: fields[7] as int?,
      updateAt: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Conversation obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userIds)
      ..writeByte(2)
      ..write(obj.messages)
      ..writeByte(3)
      ..write(obj.secondUser)
      ..writeByte(4)
      ..write(obj.latestMessage)
      ..writeByte(5)
      ..write(obj.isMute)
      ..writeByte(6)
      ..write(obj.isDeleted)
      ..writeByte(7)
      ..write(obj.createAt)
      ..writeByte(8)
      ..write(obj.updateAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
