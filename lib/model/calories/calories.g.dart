// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaloriesAdapter extends TypeAdapter<Calories> {
  @override
  final int typeId = 2;

  @override
  Calories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Calories()
      ..id = fields[0] as String
      ..user_id = fields[1] as String
      ..date = fields[2] as DateTime
      ..kCalTaken = fields[3] as double;
  }

  @override
  void write(BinaryWriter writer, Calories obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user_id)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.kCalTaken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaloriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
