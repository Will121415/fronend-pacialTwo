import 'package:flutter/material.dart';
import 'package:parcial_two/model/patient_model.dart';

class InfoProfile extends StatelessWidget {
  final Patient patient;
  InfoProfile({Key key, this.patient});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Items('Direccion', patient.address),
            Items('Barrio', patient.neighborhood),
            Items('Ciudad', patient.city),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Items('Identinicacion', patient.patientId),
            Items('Edad', patient.age),
            Items('Estado', patient.status),
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
