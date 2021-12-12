import 'package:bloc/bloc.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarRepository repo;

  CarCubit({required this.repo}) : super(CarInitial());

  Future<void> updateCar(Car car) async {
    emit(CarUpdating(car));
    await repo.putCar(car);
    emit(CarLoaded(car));
  }

  void loadCars() {
    var state = CarsLoaded(repo.getCars());
    emit(state);
  }

  void loadCar(Car car) {
    emit(CarLoaded(repo.getCar(car.id)));
  }

  Future<void> createCar(Car car) async {
    await repo.putCar(car);
    emit(CarsLoaded(repo.getCars()));
  }

  Future<void> deleteCar(Car car) async {
    await repo.removeCar(car);
    emit(CarsLoaded(repo.getCars()));
  }
}
