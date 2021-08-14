// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/signal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignalAdapter extends TypeAdapter<Signal> {
  @override
  final int typeId = 0;

  @override
  Signal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Signal()
      ..name = fields[0] as String
      ..signalGroup = fields[1] as String
      ..type = fields[2] as String
      ..alias = fields[3] as String
      ..comment = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Signal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.signalGroup)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.alias)
      ..writeByte(4)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
