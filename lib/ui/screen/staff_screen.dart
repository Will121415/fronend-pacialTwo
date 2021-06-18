import 'package:flutter/material.dart';

import 'data_staff_screen.dart';

class StaffScreen extends StatefulWidget {
  String userName;
  StaffScreen(this.userName);
  @override
  State<StatefulWidget> createState() {
    return _StaffScreen();
  }
}

class _StaffScreen extends State<StaffScreen> {
  int indexTap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal de Atencion ')),
      body: StaffData(widget.userName),
    );
  }
}
