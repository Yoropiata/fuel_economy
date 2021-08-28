

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fuel_economy/models/models.dart';

class CarEditor extends StatefulWidget {

  final Car? car;
  final Function(Car) onSubmit;

  CarEditor({
    required this.onSubmit, 
    this.car
  });

  @override
  _CarEditorState createState() => _CarEditorState();
}

class _CarEditorState extends State<CarEditor> {

  TextEditingController licensePlateController = TextEditingController(text: "");
  TextEditingController vinController = TextEditingController(text: "");

  @override
  void initState() {
    if(widget.car != null) {
      Car car = widget.car!;
      licensePlateController.text = car.licensePlate;
      vinController.text = car.vin;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        TextField(
          controller: licensePlateController,
          decoration: InputDecoration(labelText: "License plate"),
          keyboardType: TextInputType.text,
        ),
        TextField(
          controller: vinController,
          decoration: InputDecoration(labelText: "Vin"),
          keyboardType: TextInputType.name,
        ),
        ElevatedButton(
          onPressed: onSubmit, 
          child: Text("Submit")
        ),
      ]
    );
  }
  void onSubmit() {
    if(widget.car != null) {
      widget.car!;
      
      widget.onSubmit(widget.car!);
    } else {
      Car car = Car()
        ..licensePlate = licensePlateController.text
        ..vin = vinController.text;
      widget.onSubmit(car);
    }
    

  }
}