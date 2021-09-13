
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fuel_economy/fuel_economy_app.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:fuel_economy/repository/fuel_registration_repository.dart';
import 'package:fuel_economy/repository/settings_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  runZonedGuarded(() async {
    _startApp();
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

void _startApp() async {
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
}