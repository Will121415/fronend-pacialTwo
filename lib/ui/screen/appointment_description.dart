import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart';
import 'package:parcial_two/bloc/appointment_bloc%20.dart';
import 'package:parcial_two/model/appointment_model.dart';
import 'package:parcial_two/ui/widget/info_profile_patient.dart';
import 'package:intl/intl.dart';
import 'package:parcial_two/ui/screen/list_attention_staff_for_assignament.dart';

class AppointmentDescription extends StatefulWidget {
  final Appointment appointment;
  AppointmentDescription({Key key, this.appointment});
  @override
  State<StatefulWidget> createState() => _AppointmentDescription();
}

class _AppointmentDescription extends State<AppointmentDescription> {
  Appointment appointment;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateTime selectedDate = DateTime.now();
  AppointmentBloc _appointmentBloc = new AppointmentBloc();
  @override
  void initState() {
    appointment = widget.appointment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cita N°' + appointment.appointmentId.toString()),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 70, 10, 0),
              height: 460,
              width: double.maxFinite,
              // color: Colors.amber,
              child: Card(
                elevation: 5,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 55.0, left: 5.0, right: 5.0),
                        child: Column(
                          children: [
                            Text(
                              'Descripcion de la cita',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Items('Fecha de cita',
                                    "${dateFormat.format(appointment.date)}"),
                                Items('Estado de la cita', appointment.status),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Items('Paciente', appointment.patient.name),
                                Items(
                                    'Presonal de atencion',
                                    (appointment.attentionStaff != null)
                                        ? appointment.attentionStaff.name
                                        : "No asignado"),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        if (appointment.attentionStaff ==
                                            null) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ListAttentionStaff4assinament(
                                                        idAppaiment: appointment
                                                            .appointmentId),
                                              )).then((value) {
                                            if (value != null) {
                                              _appointmentBloc
                                                  .blocAssignAppointment(
                                                      appointment.appointmentId,
                                                      value)
                                                  .then((response) {
                                                Mensaje(
                                                    "La asignacion se realizo con exito",
                                                    context);
                                              });
                                            }

                                            setState(() {});
                                          });
                                        } else {
                                          this.Mensaje(
                                              "Ya se encuentra un personal de atencion registrado",
                                              context);
                                        }
                                      },
                                      child: Text('Asignar Personal'))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Mensaje(String Mensage, context) {
    Flushbar(
      title: 'Información',
      message: Mensage,
      icon: Icon(
        Icons.check_circle_outline,
        size: 28,
        color: Colors.blue.shade300,
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 12),
    )..show(context);
  }
}
