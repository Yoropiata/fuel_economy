import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:fuel_economy/repository/fuel_registration_repository.dart';
import 'package:fuel_economy/repository/settings_repository.dart';
import 'package:fuel_economy/views/car_details/car_detail_page.dart';
import 'package:fuel_economy/views/car_details/fuel_registration/fuel_registration_create_page.dart';
import 'package:fuel_economy/views/car_details/fuel_registration/fuel_registration_edit_page.dart';
import 'package:fuel_economy/views/cars/car_create_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FuelEconomyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Car? selectedCar = SettingsRepository().getSelectedCar();

    return MaterialApp(
      title: 'Fuel economy app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: _getInitialRoute(),
      routes: <String, Widget Function(BuildContext)> {
        CarCreatePage.ROUTE: (ctx) => CarCreatePage(),
        CarDetailPage.ROUTE: (ctx) => CarDetailPage(),
        FuelRegistrationCreatePage.ROUTE: (ctx) => FuelRegistrationCreatePage(),
        FuelRegistrationEditPage.ROUTE: (ctx) => FuelRegistrationEditPage(),
      },
    );
  }

  /**
   * Compute the initial route based off of whether a 
   */
  String _getInitialRoute() {
    return SettingsRepository().getSelectedCar() != null
      ? CarDetailPage.ROUTE
      : CarCreatePage.ROUTE;
  }
}