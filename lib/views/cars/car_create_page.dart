

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:fuel_economy/views/car_details/car_detail_page.dart';
import 'package:fuel_economy/views/cars/car_editor.dart';

class CarCreatePage extends StatelessWidget {
  static const String ROUTE = "/car-create";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create car page")),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: CarEditor(
              onSubmit: (c) {
                CarRepository().putCar(c);
                CarRepository().setSelectedCar(c);
                Navigator.pushReplacementNamed(context, CarDetailPage.ROUTE);
              },
            ),
          ),
        ],
      ),
    );
  }

  
}