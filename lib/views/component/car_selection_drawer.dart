
import 'package:flutter/material.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:fuel_economy/repository/car_repository.dart';
import 'package:fuel_economy/views/car_details/car_detail_page.dart';
import 'package:fuel_economy/views/cars/car_create_page.dart';

class CarSelectionDrawer extends StatelessWidget {

Function(Car) onCarSelected;
  CarSelectionDrawer({Key? key, required this.onCarSelected}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Cars'),
            ),
            
          ),
          Column(
            children: CarRepository().getCars().map((c) {
              return Card(
                child: InkWell(
                  child: ListTile(
                    title: Text(c.licensePlate),
                  ),
                  onTap: () {
                    onCarSelected(c);
                  },
                ),
              );
            }).toList(),
          ),
          ListTile(
            trailing: Icon(Icons.add),
            title: Text('Add car'),
            onTap: () {
              Navigator.pushNamed(context, CarCreatePage.ROUTE);
            },
          ),
        ],
      ),
    );
  }
}