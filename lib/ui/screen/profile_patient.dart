import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:parcial_two/bloc/appointment_bloc%20.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/ui/screen/patient_modify_screen.dart';
import 'package:parcial_two/ui/widget/image_profile.dart';
import 'package:parcial_two/ui/widget/info_profile_patient.dart';
import 'package:parcial_two/ui/widget/message_response.dart';
import 'dart:developer';

class ProfilePatient extends StatefulWidget {
  final Patient patient;
  ProfilePatient({Key key, this.patient});
  @override
  State<StatefulWidget> createState() => _ProfilePatient();
}

class _ProfilePatient extends State<ProfilePatient> {
  Patient patient;
  DateTime selectedDate = DateTime.now();
  AppointmentBloc _appointmentBloc = new AppointmentBloc();
  @override
  void initState() {
    patient = widget.patient;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del paciente ' + patient.name),
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
                  ImageProfile(patient.photo),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 55.0, left: 5.0, right: 5.0),
                      child: Column(
                        children: [
                          Text(
                            patient.name + ' ' + patient.lastName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(patient.phone),
                          InfoProfile(
                            patient: patient,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PatientModify(
                                                          patient: patient)))
                                          .then((value) {
                                        if (value != null) {
                                          setState(() {
                                            patient = value;
                                            messageResponde(context,
                                                'El paciente ${value.name} a sido modificado');
                                          });
                                        }
                                      });
                                    },
                                    child: Text('Modificar'))
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _selectDate(context),
        child: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
      fieldLabelText: 'Fecha de la cita',
      fieldHintText: 'Month/Date/Year',
      confirmText: 'Agregar cita',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _appointmentBloc
          .blocAddAppointment(selectedDate, patient.patientId)
          .then((value) {
        if (value != null) {
          Flushbar(
            title: 'Información',
            message:
                'se registro la cita exitosamente para la fecha ${value.date} y el numero de la cita es ${value.appointmentId}',
            icon: Icon(
              Icons.check_circle_outline,
              size: 28,
              color: Colors.blue.shade300,
            ),
            leftBarIndicatorColor: Colors.blue.shade300,
            duration: Duration(seconds: 12),
          )..show(context);
        }
      });
    }
  }
}
