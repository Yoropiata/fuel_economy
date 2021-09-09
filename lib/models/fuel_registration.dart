
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'fuel_registration.g.dart';

@HiveType(typeId: 0)
class FuelRegistration extends HiveObject {

  @HiveField(0)
  String id = Uuid().v4();

  @HiveField(1)
  late String carId; 

  @HiveField(2)
  DateTime time = DateTime.now();

  @HiveField(3)
  List<Image> images = [];

  @HiveField(4)
  bool didRecordLastFuelStop = false;

  @HiveField(5)
  int currentKmState = 0;

  @HiveField(6)
  int deltaKmState = 0;

  @HiveField(7)
  double litres = 0;
  
  @HiveField(8)
  double pricePerLitre = 0;
  
  @HiveField(9)
  double totalPrice = 0;
  
  @HiveField(10)
  bool didFillTank = false;
}