// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 2;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      fields[0] as String,
      fields[1] as String,
      fields[2] as bool,
      fields[3] as int,
      fields[4] as int,
      (fields[5] as HiveList?)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.completed)
      ..writeByte(3)
      ..write(obj.maxLimit)
      ..writeByte(4)
      ..write(obj.sampleSize)
      ..writeByte(5)
      ..write(obj.samples);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
