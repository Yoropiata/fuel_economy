

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fuel_economy/enums/fueling_states.dart';
import 'package:fuel_economy/helpers/decimal_text_input_formatter.dart';
import 'package:fuel_economy/models/models.dart';
import 'package:intl/intl.dart';

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

  FuelingStates? lastEdited;
  FuelingStates? currentlyEditing;

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
          controller: currentKmStateController,
          decoration: InputDecoration(labelText: "Total km"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ]
        ),
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: litresController,
                onChanged: (val) => _onFieldChanged(FuelingStates.Litres, double.parse(val)),
                decoration: InputDecoration(labelText: "Litres"),
                keyboardType: TextInputType.number,
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
              ),
            ),
            Flexible(
              child: TextField(
                controller: pricePerLitreController,
                onChanged: (val) => _onFieldChanged(FuelingStates.PricePerLitre, double.parse(val)),
                decoration: InputDecoration(labelText: "Price per litre"),
                keyboardType: TextInputType.number,
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
              ),
            ),
          ],
        ),
        TextField(
          controller: totalPriceController,
                onChanged: (val) => _onFieldChanged(FuelingStates.TotalPrice, double.parse(val)),
          decoration: InputDecoration(labelText: "Total price"),
          keyboardType: TextInputType.number,
          inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
        ),
        TextButton(
          child: Text(DateFormat('dd-MM-yyyy - HH:mm').format(time.toLocal())),
          onPressed: () {
            DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              onConfirm: (date) {
                setState(() {
                  time = date;
                });
              }, 
              currentTime: time, locale: LocaleType.da);
          }
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

  void _onFieldChanged(FuelingStates state, double value) {
    if(currentlyEditing != state) {
      lastEdited = currentlyEditing;
      currentlyEditing = state;
    }
    if(lastEdited == null) {
      return;
    }

    var totalPrice = double.tryParse(totalPriceController.text);
    var litres = double.tryParse(litresController.text);
    var pricePerLitre = double.tryParse(pricePerLitreController.text);


    if(
      (lastEdited == FuelingStates.Litres && currentlyEditing == FuelingStates.PricePerLitre) || 
      (lastEdited == FuelingStates.PricePerLitre && currentlyEditing == FuelingStates.Litres) 
    ) {
      // totalPrice when Litres && PricePerLitre
      totalPriceController.text = (litres! * pricePerLitre!).toString();
    } else if(
      (lastEdited == FuelingStates.TotalPrice && currentlyEditing == FuelingStates.Litres) ||
      (lastEdited == FuelingStates.Litres && currentlyEditing == FuelingStates.TotalPrice)
    ) {
      // pricePerLitre when TotalPrice && Litres
      pricePerLitreController.text = (totalPrice! / litres!).toString();
    } else if(
      (lastEdited == FuelingStates.TotalPrice && currentlyEditing == FuelingStates.PricePerLitre) ||
      (lastEdited == FuelingStates.PricePerLitre && currentlyEditing == FuelingStates.TotalPrice)
    ) {
      // litres when TotalPrice && PricePerLitre
      litresController.text = (totalPrice! / pricePerLitre!).toString();
    }
  }
}