// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SampleAdapter extends TypeAdapter<Sample> {
  @override
  final int typeId = 3;

  @override
  Sample read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sample(
      fields[0] as int,
      fields[1] as String,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Sample obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sample)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SampleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
