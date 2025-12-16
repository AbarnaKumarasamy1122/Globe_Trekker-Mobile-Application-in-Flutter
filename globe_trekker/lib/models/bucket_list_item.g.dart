// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_list_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BucketListItemAdapter extends TypeAdapter<BucketListItem> {
  @override
  final int typeId = 1;

  @override
  BucketListItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BucketListItem(
      id: fields[0] as String,
      country: fields[1] as Country,
      addedAt: fields[2] as DateTime,
      visited: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BucketListItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.addedAt)
      ..writeByte(3)
      ..write(obj.visited);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BucketListItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
