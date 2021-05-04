import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/bloc/attention_staff_bloc.dart';
import 'package:parcial_two/model/attention_staff_model.dart';
import 'package:parcial_two/ui/screen/attention_staff_register_screen.dart';

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
                  builder: (BuildContext context) => AttentionStaffRegister()));
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
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(
                  attentionStaff[posicion]
                      .lastName
                      .substring(0, 1)
                      .toLowerCase(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
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
                        (attentionStaff[posicion].serviceStatus == 'avaliable')
                            ? Colors.green
                            : Colors.red),
              ),
              trailing: InkWell(
                onTap: () => print('Eliminar Attention Staf'),
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
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
}
