import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:parcial_two/model/appointment_model.dart';
import 'package:parcial_two/repository/appointment_repository.dart';
import 'package:parcial_two/ui/widget/info_profile_patient.dart';
import 'package:parcial_two/ui/widget/message_response.dart';

class InfoAppointment extends StatefulWidget {
  Appointment appointment;
  InfoAppointment({Key key, this.appointment});
  @override
  State<StatefulWidget> createState() => _InfoAppointment();
}

class _InfoAppointment extends State<InfoAppointment> {
  String status_id;
  List<String> status = ["Atendido", "En Servicio", "Anulada", "Asignado"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cita N° ' + widget.appointment.appointmentId.toString()),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 30.0,
        ),
        // color: Colors.amber,
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Informacion del paciente',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InfoProfile(
              patient: widget.appointment.patient,
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Informacion de la cita',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Items('Fecha', widget.appointment.date.toString()),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Estado',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                  // color: Colors.blue,
                  width: 300,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: DropDownField(
                    value: widget.appointment.status,
                    required: false,
                    enabled: true,
                    hintText: 'Seleccionar...',
                    items: status,
                    onValueChanged: (value) {
                      setState(() {
                        if (value == "Atendido") slectStatus = 0;
                        if (value == "En Servicio") slectStatus = 1;
                        if (value == "Anulada") slectStatus = 4;
                        if (value == "Asignado") slectStatus = 3;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Regresar')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () {
                          changeStatus(
                                  widget.appointment.appointmentId, slectStatus)
                              .then((appoint) {
                            if (appoint.appointmentId != 0) {
                              messageResponde(context,
                                  'El estado de la cita ${appoint.appointmentId} a sido modificado');
                            }
                          });
                        },
                        child: Text('Guardar')),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  final ctrlStatus = new TextEditingController();
  var slectStatus = 3;
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
          width: 300,
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
