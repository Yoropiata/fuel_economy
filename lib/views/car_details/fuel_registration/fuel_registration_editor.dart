

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fuel_economy/helpers/decimal_text_input_formatter.dart';
import 'package:fuel_economy/models/models.dart';

class FuelRegistrationEditor extends StatefulWidget {

  FuelRegistration? fuelRegistration;
  final Function(FuelRegistration) onSubmit;

  FuelRegistrationEditor({
    required this.onSubmit, 
    this.fuelRegistration
  });

  @override
  _FuelRegistrationEditorState createState() => _FuelRegistrationEditorState();
}

class _FuelRegistrationEditorState extends State<FuelRegistrationEditor> {

  TextEditingController currentKmStateController = TextEditingController(text: "");
  bool didRecordLastFuelStop = true;
  bool didFillTank = true;
  TextEditingController litresController = TextEditingController(text: "");
  TextEditingController pricePerLitreController = TextEditingController(text: "");
  TextEditingController totalPriceController = TextEditingController(text: "");
  DateTime time = DateTime.now();

  @override
  void initState() {
    if(widget.fuelRegistration != null) {
      FuelRegistration fr = widget.fuelRegistration!;
      currentKmStateController.text = fr.currentKmState.toString();
      didRecordLastFuelStop = fr.didRecordLastFuelStop;
      didFillTank = fr.didFillTank;
      litresController.text = fr.litres.toString();
      pricePerLitreController.text = fr.pricePerLitre.toString();
      totalPriceController.text = fr.totalPrice.toString();
      time = fr.time;  
    } else {
      widget.fuelRegistration = new FuelRegistration();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        TextField(
          controller: litresController,
          decoration: InputDecoration(labelText: "Litres"),
          keyboardType: TextInputType.number,
          inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
        ),
        TextField(
          controller: currentKmStateController,
          decoration: InputDecoration(labelText: "Total km"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ]
        ),
        TextField(
          controller: pricePerLitreController,
          decoration: InputDecoration(labelText: "Price per litre"),
          keyboardType: TextInputType.number,
          inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
        ),
        TextField(
          controller: totalPriceController,
          decoration: InputDecoration(labelText: "Total price"),
          keyboardType: TextInputType.number,
          inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
        ),
        SwitchListTile(
          title: Text("Last fuelstop recorded."),
          subtitle: Text("Did you record the last fuelstop?"),
          value: didRecordLastFuelStop,
          onChanged: (val) {
            setState(() {
              didRecordLastFuelStop = val;
            });
          },
        ),
        SwitchListTile(
          title: Text("Filled tank"),
          subtitle: Text("Did you fill up your tank?"),
          value: didFillTank,
          onChanged: (val) {
            setState(() {
              didFillTank = val;
            });
          },
        ),
        TextButton(
          child: Text("Time recorded"),
          onPressed: () {
            DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              onConfirm: (date) {
                time = date;
              }, 
              currentTime: time, locale: LocaleType.da);
          }
        ),
        ElevatedButton(
          onPressed: onSubmit, 
          child: Text("Submit")
        ),
      ]
    );
  }
  void onSubmit() {
    widget.fuelRegistration!
      ..currentKmState = int.parse(currentKmStateController.text)
      ..litres = double.parse(litresController.text)
      ..totalPrice = double.parse(totalPriceController.text)
      ..pricePerLitre = double.parse(pricePerLitreController.text)
      ..time = time
      ..didRecordLastFuelStop = didRecordLastFuelStop
      ..didFillTank = didFillTank;
    
    widget.onSubmit(widget.fuelRegistration!);
  }
}