// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarAdapter extends TypeAdapter<Car> {
  @override
  final int typeId = 1;

  @override
  Car read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Car()
      ..id = fields[0] as String
      ..licensePlate = fields[1] as String
      ..vin = fields[2] as String
      ..fuelRegistrations = (fields[3] as List).cast<FuelRegistration>();
  }

  @override
  void write(BinaryWriter writer, Car obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.licensePlate)
      ..writeByte(2)
      ..write(obj.vin)
      ..writeByte(3)
      ..write(obj.fuelRegistrations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
