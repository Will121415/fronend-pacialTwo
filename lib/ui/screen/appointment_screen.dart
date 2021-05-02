import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/bloc/appointment_bloc%20.dart';
import 'package:parcial_two/bloc/patient_bloc.dart';
import 'package:parcial_two/model/appointment_model.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/repository/patient_repository.dart';
import 'package:parcial_two/ui/screen/patient_register_screen.dart';
import 'package:parcial_two/ui/screen/profile_patient.dart';
import 'package:parcial_two/ui/widget/message_response.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppointmentScreen();
}

class _AppointmentScreen extends State<AppointmentScreen> {
  AppointmentBloc appointmentBloc;
  @override
  Widget build(BuildContext context) {
    appointmentBloc = new AppointmentBloc();
    return Scaffold(
      body: getAppointmentBloc(context, appointmentBloc),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => PatientRagister()))
              .then((value) {
            setState(() {
              if (value != null) {
                messageResponde(
                    context, 'El paciente ${value.name} a sido guardado');
              }
            });
          });
          print('Registrar paciente...!');
        },
        tooltip: 'Registrar',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget appointmentList(List<Appointment> appointments) {
    return ListView.builder(
        itemCount: appointments == null ? 0 : appointments.length,
        itemBuilder: (context, posicion) {
          return ListTile(
              onTap: () {},
              leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 30.0,
                  child: Text(
                    appointments[posicion].patient.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              title: Text("Cita n°: "+
                appointments[posicion].AppointmentId.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                appointments[posicion].Status,
                style: TextStyle(
                    color: AsignarColor(appointments[posicion].Status))
              ),
              trailing: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              ));
        });
  }

  eliminarusuario(context, Patient patient) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('ELIMINAR PACIENTE'),
        backgroundColor: Colors.amber,
        content: Text('¿Esta Seguro de Eliminar a: ' +
            patient.name +
            " " +
            patient.lastName +
            '?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCELAR',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              deletePatient(patient.patientId).then((value) {
                if (value.patientId != '') {
                  setState(() {});
                }
              });
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAppointmentBloc(BuildContext context, AppointmentBloc appointmentBloc) {
    return FutureBuilder(
      future: appointmentBloc.blocListAppointment(http
          .Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {

          //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            if (snapshot.hasError)
              return Container(
                alignment: Alignment.center,
                child: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            // print(snapshot.data);
            return snapshot.data != null
                ? Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    // color: Colors.amber,
                    child: Container(
                      // color: Colors.blue,
                      margin: EdgeInsets.only(top: 20.0),
                      child: appointmentList(snapshot.data),
                    ),
                  )
                : Text('Sin Datos');
          default:
            return Text('Presiona el boton para recargar');
        }
      },
    );
  }

  AsignarColor(String _status){
    var status = {
      "Asignado":Colors.orange,
      "No Atendido":Colors.orangeAccent,
      "En Servicio":Colors.yellow,
      "Atendido":Colors.green,
      "Anulada":Colors.red
    };
    return status[_status];

  }
}
