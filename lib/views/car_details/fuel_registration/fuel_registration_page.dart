
import 'package:flutter/material.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/views/car_details/fuel_registration/fuel_registration_edit_page.dart';

class FuelRegistrationPage extends StatelessWidget {
  late BuildContext context;
  final Car car;
  
  FuelRegistrationPage({
    Key? key,
    required this.car
  });

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return SafeArea(
      child: ListView(
        children: car.fuelRegistrations.map(buildFuelRegistrationCard).toList(),
      ),
    );
  }

  Widget buildFuelRegistrationCard(FuelRegistration fr) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(fr.totalPrice.toString()),
        ),
        onTap: () => {
          Navigator.pushNamed(this.context, FuelRegistrationEditPage.ROUTE, arguments: fr)
        },
      ),
    );
  }
}