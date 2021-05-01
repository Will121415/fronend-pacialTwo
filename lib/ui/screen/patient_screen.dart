import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/bloc/patient_bloc.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/repository/patient_repository.dart';
import 'package:parcial_two/ui/screen/patient_register_screen.dart';
import 'package:parcial_two/ui/screen/profile_patient.dart';
import 'package:parcial_two/ui/widget/message_response.dart';

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

  Widget patientList(List<Patient> patients) {
    return ListView.builder(
        itemCount: patients == null ? 0 : patients.length,
        itemBuilder: (context, posicion) {
          return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePatient(
                        patient: patients[posicion],
                      ),
                    )).then((value) {
                  setState(() {});
                });
              },
              leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 30.0,
                  child: Text(
                    patients[posicion].name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              title: Text(
                patients[posicion].name + patients[posicion].lastName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                patients[posicion].status,
                style: TextStyle(
                    color: (patients[posicion].status == 'Active')
                        ? Colors.green
                        : Colors.red),
              ),
              trailing: InkWell(
                onTap: () => eliminarusuario(context, patients[posicion]),
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
                      child: patientList(snapshot.data),
                    ),
                  )
                : Text('Sin Datos');
          default:
            return Text('Presiona el boton para recargar');
        }
      },
    );
  }
}
