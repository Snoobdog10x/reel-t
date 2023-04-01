// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 1;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      fullName: fields[0] as String?,
      email: fields[1] as String?,
      userName: fields[2] as String?,
      bio: fields[3] as String?,
      avatar: fields[4] as String?,
      numFollower: fields[5] as int?,
      numFollowing: fields[6] as int?,
      isOnline: fields[7] as bool?,
      isActive: fields[8] as bool?,
      isDeleted: fields[9] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.bio)
      ..writeByte(4)
      ..write(obj.avatar)
      ..writeByte(5)
      ..write(obj.numFollower)
      ..writeByte(6)
      ..write(obj.numFollowing)
      ..writeByte(7)
      ..write(obj.isOnline)
      ..writeByte(8)
      ..write(obj.isActive)
      ..writeByte(9)
      ..write(obj.isDeleted);
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
