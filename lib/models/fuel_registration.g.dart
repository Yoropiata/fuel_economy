// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_registration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FuelRegistrationAdapter extends TypeAdapter<FuelRegistration> {
  @override
  final int typeId = 0;

  @override
  FuelRegistration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelRegistration()
      ..id = fields[0] as String
      ..carId = fields[1] as String
      ..time = fields[2] as DateTime
      ..images = (fields[3] as List).cast<Image>()
      ..didRecordLastFuelStop = fields[4] as bool
      ..currentKmState = fields[5] as int
      ..deltaKmState = fields[6] as int
      ..litres = fields[7] as double
      ..pricePerLitre = fields[8] as double
      ..totalPrice = fields[9] as double
      ..didFillTank = fields[10] as bool;
  }

  @override
  void write(BinaryWriter writer, FuelRegistration obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.carId)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.images)
      ..writeByte(4)
      ..write(obj.didRecordLastFuelStop)
      ..writeByte(5)
      ..write(obj.currentKmState)
      ..writeByte(6)
      ..write(obj.deltaKmState)
      ..writeByte(7)
      ..write(obj.litres)
      ..writeByte(8)
      ..write(obj.pricePerLitre)
      ..writeByte(9)
      ..write(obj.totalPrice)
      ..writeByte(10)
      ..write(obj.didFillTank);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelRegistrationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
