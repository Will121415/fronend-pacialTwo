import 'package:flutter/material.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/ui/widget/image_profile.dart';
import 'package:parcial_two/ui/widget/info_profile.dart';

class ProfilePatient extends StatelessWidget {
  final Patient patient;
  ProfilePatient({Key key, this.patient});
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
                  ImageProfile(),
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
                            height: 15.0,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Regresar'))
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
    );
  }
}
