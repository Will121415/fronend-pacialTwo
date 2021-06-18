import 'package:flutter/material.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/ui/screen/patient_modify_screen.dart';
import 'package:parcial_two/ui/widget/image_profile.dart';
import 'package:parcial_two/ui/widget/info_profile_patient.dart';
import 'package:parcial_two/ui/widget/message_response.dart';

class ProfilePatient extends StatefulWidget {
  final Patient patient;
  ProfilePatient({Key key, this.patient});
  @override
  State<StatefulWidget> createState() => _ProfilePatient();
}

class _ProfilePatient extends State<ProfilePatient> {
  Patient patient;

  @override
  void initState() {
    patient = widget.patient;
    super.initState();
  }

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
                  ImageProfile(patient.photo),
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
                                                      PatientModify(
                                                          patient: patient)))
                                          .then((value) {
                                        if (value != null) {
                                          setState(() {
                                            patient = value;
                                            messageResponde(context,
                                                'El paciente ${value.name} a sido modificado');
                                          });
                                        }
                                      });
                                    },
                                    child: Text('Modificar'))
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
      ),
    );
  }
}
