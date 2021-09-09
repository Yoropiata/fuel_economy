

import 'package:flutter/material.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:fuel_economy/repository/settings_repository.dart';
import 'package:fuel_economy/views/car_details/car_detail_page.dart';
import 'package:fuel_economy/views/car_details/fuel_registration/fuel_registration_editor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

class FuelRegistrationCreatePage extends StatelessWidget {
  static const String ROUTE = "/fuel-registration-create";

  @override
  Widget build(BuildContext context) {
    AppLocalizations trans = AppLocalizations.of(context) ?? AppLocalizationsEn();
    
    return Scaffold(
      appBar: AppBar(title: Text(trans.createFuelRegistration)),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: FuelRegistrationEditor(
              onSubmit: (fr) {
                Car car = SettingsRepository().getSelectedCar()!;
                car.fuelRegistrations.add(fr);
                CarRepository().putCar(car);

                Navigator.pushReplacementNamed(context, CarDetailPage.ROUTE);
              },
            ),
          ),
        ],
      ),
    );
  }

}