import 'package:flutter/material.dart';
import 'package:fuel_economy/models/models.dart';

class CarDashboard extends StatelessWidget {
  final Car car;
  CarDashboard({required this.car});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Card(
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(car.licensePlate),
              ),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}