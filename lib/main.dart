
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fuel_economy/auth_gate.dart';
import 'package:fuel_economy/fuel_economy_app.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:fuel_economy/repository/fuel_registration_repository.dart';
import 'package:fuel_economy/repository/settings_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  runZonedGuarded(() async {
    _startApp();
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

void _startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // SHA256: 9D:56:61:54:F6:A6:49:B6:6D:F4:37:5A:94:F3:19:3E:17:1D:0A:72:D7:B8:A6:74:C2:24:CB:1F:E5:60:7B:54
  // token is: F488C3CB-CC85-44CF-B3D5-5AD1174744D4
  await FirebaseAppCheck.instance.activate();
  await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  await Hive.initFlutter();
  Hive.registerAdapter(FuelRegistrationAdapter());
  Hive.registerAdapter(CarAdapter());
  await CarRepository.initialize();
  await FuelRegistrationRepository.initialize();
  await SettingsRepository.initialize();
  
  runApp(AuthGate());
}