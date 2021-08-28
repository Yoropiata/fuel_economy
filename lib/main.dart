
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:fuel_economy/views/car_details/car_detail_page.dart';
import 'package:fuel_economy/views/car_details/fuel_registration/fuel_registration_create_page.dart';
import 'package:fuel_economy/views/car_details/fuel_registration/fuel_registration_edit_page.dart';
import 'package:fuel_economy/views/cars/car_create_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(FuelRegistrationAdapter());
  Hive.registerAdapter(CarAdapter());
  await CarRepository.initialize();
  
  runApp(FuelEconomyApp());
}

class FuelEconomyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel economy app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: CarDetailPage.ROUTE,
      routes: <String, Widget Function(BuildContext)> {
        CarCreatePage.ROUTE: (ctx) => CarCreatePage(),
        CarDetailPage.ROUTE: (ctx) => CarDetailPage(),
        FuelRegistrationCreatePage.ROUTE: (ctx) => FuelRegistrationCreatePage(),
        FuelRegistrationEditPage.ROUTE: (ctx) => FuelRegistrationEditPage(),
      },
    );
  }
}