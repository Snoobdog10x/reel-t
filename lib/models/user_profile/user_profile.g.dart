// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      id: fields[0] as String?,
      fullName: fields[1] as String?,
      email: fields[2] as String?,
      userName: fields[3] as String?,
      bio: fields[4] as String?,
      birthday: fields[5] as String?,
      avatar: fields[6] as String?,
      numFollower: fields[7] as int?,
      numFollowing: fields[8] as int?,
      numLikes: fields[9] as int?,
      isOnline: fields[10] as bool?,
      isActive: fields[11] as bool?,
      isDeleted: fields[12] as bool?,
      createAt: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.bio)
      ..writeByte(5)
      ..write(obj.birthday)
      ..writeByte(6)
      ..write(obj.avatar)
      ..writeByte(7)
      ..write(obj.numFollower)
      ..writeByte(8)
      ..write(obj.numFollowing)
      ..writeByte(9)
      ..write(obj.numLikes)
      ..writeByte(10)
      ..write(obj.isOnline)
      ..writeByte(11)
      ..write(obj.isActive)
      ..writeByte(12)
      ..write(obj.isDeleted)
      ..writeByte(13)
      ..write(obj.createAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
