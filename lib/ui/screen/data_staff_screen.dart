import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcial_two/bloc/attention_staff_bloc.dart';
import 'package:parcial_two/model/attention_staff_model.dart';
import 'package:parcial_two/ui/screen/view_appointment_screen.dart';
import 'package:parcial_two/ui/widget/image_profile.dart';
import 'package:parcial_two/ui/widget/info_profile_attention_staff.dart';
import 'package:http/http.dart' as http;

class StaffData extends StatefulWidget {
  String userName;
  StaffData(this.userName);

  @override
  State<StatefulWidget> createState() => _StaffData();
}

class _StaffData extends State<StaffData> {
  AttentionStaffBloc attentionStaffBloc;

  @override
  Widget build(BuildContext context) {
    attentionStaffBloc = new AttentionStaffBloc();

    return Scaffold(body: getAttentionStaff(context, attentionStaffBloc));
  }

  Widget ProfileStaff(List<AttentionStaff> attentionStaff) {
    AttentionStaff staff = attentionStaff.firstWhere(
        (AttentionStaff staff) => staff.user.userName == widget.userName);

    print(widget.userName);
    print(staff.user.userName);
    return ListView(
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
                ImageProfile(staff.photo),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 55.0, left: 5.0, right: 5.0),
                    child: Column(
                      children: [
                        Text(
                          staff.name + ' ' + staff.lastName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InfoProfileStaff(
                          staff: staff,
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
                                                ViewAppointment(
                                                    staff.attentionId)));
                                  },
                                  child: Text('Ver Citas'))
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
                    // color: Colors.amber,
                    child: Container(
                      // color: Colors.blue,
                      margin: EdgeInsets.only(top: 20.0),
                      child: ProfileStaff(snapshot.data),
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
