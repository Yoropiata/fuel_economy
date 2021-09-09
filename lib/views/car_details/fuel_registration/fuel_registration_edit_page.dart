import 'package:flutter/material.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:fuel_economy/repository/settings_repository.dart';
import 'package:fuel_economy/views/car_details/fuel_registration/fuel_registration_editor.dart';

class FuelRegistrationEditPage extends StatelessWidget {
  static const String ROUTE = "/fuel-registration-edit";
  
  @override
  Widget build(BuildContext context) {
    late final FuelRegistration fuelRegistration;
    try {
      fuelRegistration = ModalRoute.of(context)?.settings.arguments as FuelRegistration;
    } catch(Exception) {
      Navigator.pop(context);
      return Text("Error");
    }
    
    return Scaffold(
      appBar: AppBar(title: Text("Create fuel registration")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FuelRegistrationEditor(
              fuelRegistration: fuelRegistration,
              onSubmit: (fr) {
                SettingsRepository().getSelectedCar()!.fuelRegistrations.add(fr);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

}