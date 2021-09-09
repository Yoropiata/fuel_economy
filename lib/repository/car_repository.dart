
import 'package:fuel_economy/models/models.dart';
import 'package:hive/hive.dart';

class CarRepository {
  static final String _boxCars = "cars";
  static final String _boxSettings = "settings";
  static final String _selectedCar = "selectedCar";

  static Future<void> initialize() async {
    await Hive.openBox<Car>(_boxCars);
    await Hive.openBox<String>(_boxSettings);
  }
  
  List<Car> getCars() {
    var box = Hive.box<Car>(_boxCars);
    var cars = box.values.toList();
    return cars;
  }

  Car? getCar(String id) {
    var car = Hive.box<Car>(_boxCars).get(id);
    return car;
  }

  Future<void> putCar(Car car) {
    return Hive.box<Car>(_boxCars).put(car.id, car);
  }

  Future<void> removeCar(Car car) {
    return Hive.box<Car>(_boxCars).delete(car.id);
  }
}