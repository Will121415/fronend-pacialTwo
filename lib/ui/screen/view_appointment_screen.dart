import 'package:flutter/material.dart';
import 'package:parcial_two/bloc/appointment_bloc%20.dart';
import 'package:parcial_two/model/appointment_model.dart';
import 'package:parcial_two/ui/screen/info_appointment_screen.dart';
import 'package:parcial_two/ui/widget/message_response.dart';

class ViewAppointment extends StatefulWidget {
  String attentionId;
  ViewAppointment(this.attentionId);
  @override
  State<StatefulWidget> createState() => _ViewAppointment();
}

class _ViewAppointment extends State<ViewAppointment> {
  AppointmentBloc appointmentBloc;
  @override
  Widget build(BuildContext context) {
    appointmentBloc = new AppointmentBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text('Citas'),
      ),
      body: getAppointmentBloc(context, appointmentBloc),
    );
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
                    builder: (context) => InfoAppointment(
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
                appointments[posicion].appointmentId.toString(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            subtitle: Text(
              appointments[posicion].date.toString(),
              style: TextStyle(color: Colors.black87),
            ),
            title: Text(
                appointments[posicion].patient.name +
                    ' ' +
                    appointments[posicion].patient.lastName,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            trailing: Text(appointments[posicion].status,
                style: TextStyle(
                    color: asignarColor(appointments[posicion].status))),
          );
        });
  }

  Widget getAppointmentBloc(
      BuildContext context, AppointmentBloc appointmentBloc) {
    return FutureBuilder(
      future: appointmentBloc.blocFindByIdStaff(widget
          .attentionId), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
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

  asignarColor(String _status) {
    var status = {
      "Asignado": Colors.orange,
      "No Atendido": Colors.orangeAccent,
      "En Servicio": Colors.yellow,
      "Atendido": Colors.green,
      "Anulada": Colors.red
    };
    return status[_status];
  }
}
