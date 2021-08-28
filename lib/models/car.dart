
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

part 'car.g.dart';

@HiveType(typeId: 1)
class Car extends HiveObject {

  @HiveField(0)
  String id = Uuid().v4();

  @HiveField(1)
  String licensePlate = "";

  @HiveField(2)
  String vin = "";

  @HiveField(3)
  List<FuelRegistration> fuelRegistrations = [];
}