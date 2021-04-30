import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/bloc/patient_bloc.dart';
import 'package:parcial_two/ui/screen/patient_register_screen.dart';
import 'package:parcial_two/ui/widget/patinet_list.dart';

class PatientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PatientScreen();
}

class _PatientScreen extends State<PatientScreen> {
  PatientBloc patientBloc;
  @override
  Widget build(BuildContext context) {
    patientBloc = new PatientBloc();
    return Scaffold(
      body: getPatient(context, patientBloc),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => PatientRagister()))
              .then((value) {
            setState(() {
              print(value);
            });
          });
          print('Registrar paciente...!');
        },
        tooltip: 'Registrar',
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget getPatient(BuildContext context, PatientBloc patientBloc) {
  return FutureBuilder(
    future: patientBloc.blocListPatient(http
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
                    child: PatientList(snapshot.data),
                  ),
                )
              : Text('Sin Datos');
        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}
