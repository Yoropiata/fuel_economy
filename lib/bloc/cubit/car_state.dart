part of 'car_cubit.dart';

@immutable
abstract class CarState {}

class CarInitial extends CarState {}

class CarsLoaded extends CarState {
  final List<Car> cars;
  CarsLoaded(this.cars);
}

class CarLoaded extends CarState {
  final Car? car;
  CarLoaded(this.car);
}

class CarUpdating extends CarLoaded {
  CarUpdating(Car car) : super(car);
}
