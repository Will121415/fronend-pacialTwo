import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/bloc/appointment_bloc%20.dart';
import 'package:parcial_two/bloc/patient_bloc.dart';
import 'package:parcial_two/model/appointment_model.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/repository/patient_repository.dart';
import 'package:parcial_two/ui/screen/patient_register_screen.dart';
import 'package:parcial_two/ui/screen/appointment_description.dart';
import 'package:parcial_two/ui/widget/message_response.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppointmentScreen();
}

class _AppointmentScreen extends State<AppointmentScreen> {
  int option = 0;
  AppointmentBloc appointmentBloc;
  @override
  Widget build(BuildContext context) {
    appointmentBloc = new AppointmentBloc();
    return Scaffold(
        body: getAppointmentBloc(context, appointmentBloc, option),
        floatingActionButton: SpeedDial(
            icon: Icons.menu,
            backgroundColor: Colors.amber,
            overlayColor: Colors.grey,
            children: [
              SpeedDialChild(
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.person_remove_alt_1_outlined,
                  color: Colors.black,
                ),
                label: 'citas sin personal asignado',
                labelBackgroundColor: Colors.amber,
                onTap: () {
                  option = 1;
                  setState(() {});
                },
              ),
              SpeedDialChild(
                backgroundColor: Colors.amber,
                child: Icon(Icons.fact_check, color: Colors.black),
                label: 'Citas con informacion completa',
                labelBackgroundColor: Colors.amber,
                onTap: () {
                  option = 2;
                  setState(() {});
                },
              ),
              SpeedDialChild(
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.all_inbox,
                  color: Colors.black,
                ),
                label: 'Todas las citas',
                labelBackgroundColor: Colors.amber,
                onTap: () {
                  option = 0;
                  setState(() {});
                },
              ),
            ]));
  }

  Widget appointmentList(List<Appointment> appointments) {
    return ListView.builder(
        itemCount: appointments == null ? 0 : appointments.length,
        itemBuilder: (context, posicion) {
          return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentDescription(
                        appointment: appointments[posicion],
                      ),
                    )).then((value) {
                  setState(() {});
                });
              },
              leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 30.0,
                  child: Text(
                    appointments[posicion]
                        .patient
                        .name
                        .substring(0, 1)
                        .toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              title: Text(
                "Cita n°: " + appointments[posicion].appointmentId.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(appointments[posicion].status,
                  style: TextStyle(
                      color: AsignarColor(appointments[posicion].status))),
              trailing: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              ));
        });
  }

  Widget getAppointmentBloc(
      BuildContext context, AppointmentBloc appointmentBloc, int option) {
    return FutureBuilder(
      future: optionSelect(appointmentBloc,
          option), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
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
                : Container(
                    alignment: Alignment.center,
                    child: Text("No hay datos"),
                  );
          default:
            return Text('Presiona el boton para recargar');
        }
      },
    );
  }

  AsignarColor(String _status) {
    var status = {
      "Asignado": Colors.orange,
      "No Atendido": Colors.orangeAccent,
      "En Servicio": Colors.yellow,
      "Atendido": Colors.green,
      "Anulada": Colors.red
    };
    return status[_status];
  }

  optionSelect(AppointmentBloc appointmentBloc, int option) {
    ;

    switch (option) {
      case 0:
        return appointmentBloc.blocListAppointment(http.Client());
      case 1:
        return appointmentBloc.blocListAppointmentUserNull(http.Client());
      case 2:
        return appointmentBloc.blocListAppointmentUserNoNull(http.Client());
      default:
        return appointmentBloc.blocListAppointment(http.Client());
    }
  }

  _showChoiceDialog(BuildContext context) {
    TextEditingController Fecha = TextEditingController();
    TextEditingController IdDeEstudiante = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text("Elegir foto"),
              content: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[],
              )));
        });
  }
}
