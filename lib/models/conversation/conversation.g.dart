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
      firstUserId: fields[1] as String?,
      secondUserId: fields[2] as String?,
      messages: (fields[3] as List?)?.cast<Message>(),
      secondUser: (fields[4] as List?)?.cast<UserProfile>(),
      isMute: fields[5] as bool?,
      isDeleted: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Conversation obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstUserId)
      ..writeByte(2)
      ..write(obj.secondUserId)
      ..writeByte(3)
      ..write(obj.messages)
      ..writeByte(4)
      ..write(obj.secondUser)
      ..writeByte(5)
      ..write(obj.isMute)
      ..writeByte(6)
      ..write(obj.isDeleted);
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
