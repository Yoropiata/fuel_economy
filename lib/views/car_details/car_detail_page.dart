
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_economy/bloc/cubit/car_cubit.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:fuel_economy/repository/settings_repository.dart';
import 'package:fuel_economy/views/car_details/car_dashboard_page.dart';
import 'package:fuel_economy/views/car_details/fuel_registration/fuel_registration_create_page.dart';
import 'package:fuel_economy/views/car_details/fuel_registration/fuel_registration_page.dart';
import 'package:fuel_economy/views/cars/car_create_page.dart';
import 'package:fuel_economy/views/component/car_bottom_navbar.dart';
import 'package:fuel_economy/views/component/car_selection_drawer.dart';

class CarDetailPage extends StatefulWidget {
  static const String ROUTE = "/car-details";

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  CarRepository repo = CarRepository();

  int selectedIndex = 0;
  late Car car;
  late Widget selectedWidget;

  late List<Widget> widgets;

  @override
  void initState() {
    car = SettingsRepository().getSelectedCar()!;
    
    widgets = [
      CarDashboard(car: car),
      FuelRegistrationPage(car: car),
    ];
    
    selectedWidget = widgets[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    car = SettingsRepository().getSelectedCar()!;
    widgets = [
      CarDashboard(car: car),
      FuelRegistrationPage(car: car),
    ];
    selectedWidget = widgets[selectedIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Car Detail Page")),
      endDrawer: CarSelectionDrawer(onCarSelected: updateCar),
      body: selectedWidget,
      bottomNavigationBar: CarBottomNavbar(onNewTabSelected: updatePage),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, FuelRegistrationCreatePage.ROUTE),
      ),
    );
  }

  void updateCar(Car car) {
    setState(() {
      SettingsRepository().setSelectedCar(car);
      // selectedIndex = 0;
      this.car = car;
      // Navigator.pushReplacementNamed(context, CarDetailPage.ROUTE);
    });
  }

  void updatePage(int i) {
    setState(() {
      selectedIndex = i;
    });
  }
}