import 'package:flutter/material.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/repository/patient_repository.dart';
import 'package:parcial_two/ui/widget/button_generic.dart';
import 'package:parcial_two/ui/widget/text_field.dart';

class PatientRagister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PatientRagister();
}

class _PatientRagister extends State<PatientRagister> {
  //Controllers
  TextEditingController ctrlPatientId;
  TextEditingController ctrlStatus;
  TextEditingController ctrlName;
  TextEditingController ctrlLastName;
  TextEditingController ctrlPhoto;
  TextEditingController ctrlAge;
  TextEditingController ctrlAddress;
  TextEditingController ctrlNeighborhood;
  TextEditingController ctrlPhone;
  TextEditingController ctrlCity;

  @override
  void initState() {
    // Init Person
    ctrlPatientId = TextEditingController();
    ctrlStatus = TextEditingController();
    ctrlName = TextEditingController();
    ctrlLastName = TextEditingController();
    ctrlPhoto = TextEditingController();
    ctrlAge = TextEditingController();
    ctrlAddress = TextEditingController();
    ctrlNeighborhood = TextEditingController();
    ctrlPhone = TextEditingController();
    ctrlCity = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar paciente'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: ListView(
          children: [
            SizedBox(
              height: 5.0,
            ),
            MyTextField(
              myController: ctrlPatientId,
              myLabel: 'Identificacion',
            ),
            MyTextField(
              myController: ctrlName,
              myLabel: 'Nombres',
            ),
            MyTextField(myController: ctrlLastName, myLabel: 'Apellidos'),
            MyTextField(myController: ctrlAge, myLabel: 'Edad'),
            MyTextField(myController: ctrlAddress, myLabel: 'Direccion'),
            MyTextField(myController: ctrlNeighborhood, myLabel: 'Barrio'),
            MyTextField(myController: ctrlPhone, myLabel: 'Telefono'),
            MyTextField(myController: ctrlCity, myLabel: 'Ciudad'),
            ButtonGeneric(
              title: 'Guardar',
              onPressed: () {
                Patient patient = Patient(
                  patientId: ctrlPatientId.text,
                  status: 'Active',
                  name: ctrlName.text,
                  lastName: ctrlLastName.text,
                  photo: 'Sinfoto',
                  age: ctrlAge.text,
                  address: ctrlAddress.text,
                  neighborhood: ctrlNeighborhood.text,
                  phone: ctrlPhone.text,
                  city: ctrlCity.text,
                );

                addPatient(patient).then((patient) {
                  if (patient.patientId != '') {
                    Navigator.pop(context, patient);
                  }
                });
              },
              height: 50,
              width: 150,
            ),
            SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
