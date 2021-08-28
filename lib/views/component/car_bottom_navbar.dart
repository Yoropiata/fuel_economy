

import 'package:flutter/material.dart';

class CarBottomNavbar extends StatefulWidget {
  void Function(int)? onNewTabSelected;
  CarBottomNavbar({
    Key? key,
    this.onNewTabSelected,
  }) : super(key: key);

  @override
  _CarBottomNavbarState createState() => _CarBottomNavbarState();
}

class _CarBottomNavbarState extends State<CarBottomNavbar> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_graph),
          label: "Min kørsel",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_gas_station_outlined),
          label: "Tankinger"
        )
      ],
      onTap: (i) {
        setState(() {
          selectedItem = i;
        });
        widget.onNewTabSelected?.call(i);
      },
      currentIndex: selectedItem,
    );
  }
}