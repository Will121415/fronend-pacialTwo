import 'package:flutter/material.dart';
import 'package:parcial_two/ui/screen/attetion_staff_screen.dart';
import 'package:parcial_two/ui/screen/patient_screen.dart';

import 'appointment_screen.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminScreen();
  }
}

class _AdminScreen extends State<AdminScreen> {
  int indexTap = 0;

  final List<Widget> widgetsChildren = [
    PatientScreen(),
    AttentionStaffScreen(),
    AppointmentScreen()
  ];

  void onTapTapped(int index) {
    setState(() {
      indexTap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:selectTitle(indexTap),
      ),
      body: widgetsChildren[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context),
        child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: onTapTapped,
            currentIndex: indexTap,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'paciente',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_sharp),
                label: 'p. atencion',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Citas',
              ),
            ]),
      ),
    );
  }

  selectTitle(int index){
    var titles = ["Paciente","Personal de atencion","Citas"];
    return Text(titles[index]);
  }
}
