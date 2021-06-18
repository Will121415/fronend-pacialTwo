import 'package:flutter/material.dart';
import 'package:parcial_two/model/attention_staff_model.dart';

class InfoProfileStaff extends StatelessWidget {
  final AttentionStaff staff;
  InfoProfileStaff({Key key, this.staff});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Items('Identificacion', staff.attentionId),
            Items('Cargo', staff.type),
            Items('Estado', staff.serviceStatus),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Datos de credenciales',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Items('Usuario', staff.user.userName),
            Items('Estado', staff.user.status),
            Items('Rol', staff.user.role),
          ],
        )
      ],
    );
  }
}

class Items extends StatelessWidget {
  String title, _text;
  Items(this.title, this._text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          this.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30,
          width: 120,
          child: Card(
            elevation: 5,
            child: Text(
              _text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
