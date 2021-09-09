
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:hive/hive.dart';

class SettingsRepository {
  static final String _boxSettings = "settings";
  static final String _selectedCar = "selectedCar";

  static Future<void> initialize() async {
    await Hive.openBox<String>(_boxSettings);
  }

  Car? getSelectedCar() {
    try {
      String carId = Hive.box<String>(_boxSettings).get(_selectedCar) ?? CarRepository().getCars().first.id;
      return CarRepository().getCar(carId);
    } catch (StateError) {
      return null;
    }
  }
  Future<void> setSelectedCar(Car car) {
    return Hive.box<String>(_boxSettings).put(_selectedCar, car.id);
  }
}