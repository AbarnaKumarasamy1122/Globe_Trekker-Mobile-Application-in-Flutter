// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryAdapter extends TypeAdapter<Country> {
  @override
  final int typeId = 0;

  @override
  Country read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Country(
      name: fields[0] as String,
      capital: fields[1] as String,
      population: fields[2] as int,
      flag: fields[3] as String,
      abbreviation: fields[4] as String,
      currency: fields[5] as String,
      phone: fields[6] as String,
      emblem: fields[7] as String?,
      orthographic: fields[8] as String?,
      id: fields[9] as int,
      region: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Country obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.capital)
      ..writeByte(2)
      ..write(obj.population)
      ..writeByte(3)
      ..write(obj.flag)
      ..writeByte(4)
      ..write(obj.abbreviation)
      ..writeByte(5)
      ..write(obj.currency)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.emblem)
      ..writeByte(8)
      ..write(obj.orthographic)
      ..writeByte(9)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.region);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
