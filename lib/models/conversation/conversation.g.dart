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
      contactUser: (fields[2] as List?)?.cast<UserProfile>(),
      latestMessage: fields[3] as String?,
      isMute: fields[4] as bool?,
      isDeleted: fields[5] as bool?,
      createAt: fields[6] as int?,
      updateAt: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Conversation obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userIds)
      ..writeByte(2)
      ..write(obj.contactUser)
      ..writeByte(3)
      ..write(obj.latestMessage)
      ..writeByte(4)
      ..write(obj.isMute)
      ..writeByte(5)
      ..write(obj.isDeleted)
      ..writeByte(6)
      ..write(obj.createAt)
      ..writeByte(7)
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
