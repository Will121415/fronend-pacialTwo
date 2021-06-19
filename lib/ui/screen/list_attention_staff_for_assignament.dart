import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/bloc/appointment_bloc%20.dart';
import 'package:parcial_two/bloc/attention_staff_bloc.dart';
import 'package:parcial_two/model/attention_staff_model.dart';

class ListAttentionStaff4assinament extends StatefulWidget {
  final int idAppaiment;
  ListAttentionStaff4assinament({Key key, this.idAppaiment});
  @override
  State<StatefulWidget> createState() => _ListAttentionStaff4assinament();
}

class _ListAttentionStaff4assinament
    extends State<ListAttentionStaff4assinament> {
  AttentionStaffBloc attentionStaffBloc;
  AppointmentBloc _appointmentBloc = new AppointmentBloc();
  @override
  Widget build(BuildContext context) {
    attentionStaffBloc = new AttentionStaffBloc();
    return Scaffold(body: getAttentionStaff(context, attentionStaffBloc));
  }

  Widget attentionStaftList(List<AttentionStaff> attentionStaff) {
    return ListView.builder(
        itemCount: attentionStaff == null ? 0 : attentionStaff.length,
        itemBuilder: (context, posicion) {
          return ListTile(
              onTap: () {
                _showAlertDialog(context, attentionStaff[posicion]);
              },
              title: Text(
                attentionStaff[posicion].name +
                    ' ' +
                    attentionStaff[posicion].lastName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                attentionStaff[posicion].serviceStatus,
                style: TextStyle(
                    color:
                        (attentionStaff[posicion].serviceStatus == 'available')
                            ? Colors.green
                            : Colors.red),
              ));
        });
  }

  Widget getAttentionStaff(
      BuildContext context, AttentionStaffBloc attentionStaffBloc) {
    return FutureBuilder(
      future: attentionStaffBloc.blocListAttention(http
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
                      child: attentionStaftList(snapshot.data),
                    ),
                  )
                : Text('Sin Datos');
          default:
            return Text('Lista de personal de atencion');
        }
      },
    );
  }

  void _showAlertDialog(context, AttentionStaff userStaff) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Confirmar"),
            content: Text(
                "Desea asignar la cita n°${widget.idAppaiment} al personal de atencion seleccionado (${userStaff.name})"),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: Text(
                  "ACEPTAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.maybeOf(context)..pop()..pop(userStaff.attentionId);
                },
              )
            ],
          );
        });
  }
}
