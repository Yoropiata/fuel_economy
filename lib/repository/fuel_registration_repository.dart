
import 'package:fuel_economy/models/models.dart';
import 'package:hive/hive.dart';

class FuelRegistrationRepository {
  static final String _boxFuelRegistration = "fuelRegistrations";

  static Future<void> initialize() async {
    await Hive.openBox<FuelRegistration>(_boxFuelRegistration);
  }

  List<FuelRegistration> getFuelRegistrations({Car? byCar}) {
    var box = Hive.box<FuelRegistration>(_boxFuelRegistration);
    Iterable<FuelRegistration> fuelRegistrations = box.values;
    if(byCar != null) {
      return fuelRegistrations.where((fr) => fr.carId == byCar.id).toList();
    }
    return fuelRegistrations.toList();
  }

  FuelRegistration? getFuelRegistration(String id) {
    var fuelRegistration = Hive.box<FuelRegistration>(_boxFuelRegistration).get(id);
    return fuelRegistration;
  }

  Future<void> putFuelRegistration(FuelRegistration fuelRegistration) {
    return Hive.box<FuelRegistration>(_boxFuelRegistration).put(fuelRegistration.id, fuelRegistration);
  }

  Future<void> removeFuelRegistration(FuelRegistration fuelRegistration) {
    return Hive.box<FuelRegistration>(_boxFuelRegistration).delete(fuelRegistration.id);
  }
}