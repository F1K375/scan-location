// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_check_in.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogCheckInAdapter extends TypeAdapter<LogCheckIn> {
  @override
  final int typeId = 1;

  @override
  LogCheckIn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogCheckIn()
      ..position = fields[0] as String
      ..distance = fields[2] as double
      ..isCheckIn = fields[3] as bool
      ..checkInAt = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, LogCheckIn obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.isCheckIn)
      ..writeByte(4)
      ..write(obj.checkInAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogCheckInAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
