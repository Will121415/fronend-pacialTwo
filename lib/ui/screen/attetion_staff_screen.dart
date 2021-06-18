import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/bloc/attention_staff_bloc.dart';
import 'package:parcial_two/model/attention_staff_model.dart';
import 'package:parcial_two/repository/attention_staff_repository.dart';
import 'package:parcial_two/ui/screen/attention_staff_register_screen.dart';
import 'package:parcial_two/ui/screen/profile_attention_staff.dart';
import 'package:parcial_two/ui/widget/message_response.dart';

class AttentionStaffScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AttentionStaffScreen();
}

class _AttentionStaffScreen extends State<AttentionStaffScreen> {
  AttentionStaffBloc attentionStaffBloc;
  @override
  Widget build(BuildContext context) {
    attentionStaffBloc = new AttentionStaffBloc();
    return Scaffold(
      body: getAttentionStaff(context, attentionStaffBloc),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AttentionStaffRegister())).then((value) => {
                setState(() {
                  if (value != null) {
                    messageResponde(context,
                        'El personal de atencion ${value.name} a sido guardado');
                  }
                })
              });
        },
        tooltip: 'Registrar',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget attentionStaftList(List<AttentionStaff> attentionStaff) {
    return ListView.builder(
        itemCount: attentionStaff == null ? 0 : attentionStaff.length,
        itemBuilder: (context, posicion) {
          return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileAttentionStaff(
                        staff: attentionStaff[posicion],
                      ),
                    )).then((value) {
                  setState(() {});
                });
              },
              leading: ClipRRect(
                borderRadius: new BorderRadius.circular(30.0),
                child: Image.memory(
                  Base64Codec().decode(attentionStaff[posicion].photo),
                  fit: BoxFit.cover,
                ),
              ),
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
              ),
              trailing: InkWell(
                onTap: () => eliminarusuario(context, attentionStaff[posicion]),
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              ));
        });
  }

  eliminarusuario(context, AttentionStaff staff) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('ELIMINAR PERSONAL DE ATENCION'),
        backgroundColor: Colors.amber,
        content: Text('¿Esta Seguro de Eliminar a: ' +
            staff.name +
            " " +
            staff.lastName +
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
              deleteAttentionStaff(staff.attentionId).then((value) {
                if (value.attentionId != '') {
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
}
