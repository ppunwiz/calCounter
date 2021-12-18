// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_login.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class isLoginAdapter extends TypeAdapter<isLogin> {
  @override
  final int typeId = 4;

  @override
  isLogin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return isLogin()
      ..userId = fields[0] as String
      ..login = fields[1] as bool
      ..deviceId = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, isLogin obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.login)
      ..writeByte(2)
      ..write(obj.deviceId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is isLoginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
