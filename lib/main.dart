
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

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    await Hive.initFlutter();
    Hive.registerAdapter(FuelRegistrationAdapter());
    Hive.registerAdapter(CarAdapter());
    await CarRepository.initialize();
    await FuelRegistrationRepository.initialize();
    await SettingsRepository.initialize();
    
    runApp(FuelEconomyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
  
}

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
      initialRoute: selectedCar != null 
        ? CarDetailPage.ROUTE 
        : CarCreatePage.ROUTE,
      routes: <String, Widget Function(BuildContext)> {
        CarCreatePage.ROUTE: (ctx) => CarCreatePage(),
        CarDetailPage.ROUTE: (ctx) => CarDetailPage(),
        FuelRegistrationCreatePage.ROUTE: (ctx) => FuelRegistrationCreatePage(),
        FuelRegistrationEditPage.ROUTE: (ctx) => FuelRegistrationEditPage(),
      },
    );
  }
}