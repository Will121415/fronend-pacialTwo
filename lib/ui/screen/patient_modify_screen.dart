import 'package:flutter/material.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/repository/patient_repository.dart';
import 'package:parcial_two/ui/widget/button_generic.dart';
import 'package:parcial_two/ui/widget/text_field.dart';

class PatientModify extends StatefulWidget {
  final Patient patient;
  PatientModify({Key ket, this.patient});
  @override
  State<StatefulWidget> createState() => _PatientModify();
}

class _PatientModify extends State<PatientModify> {
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

  bool isActive;
  String statusTxt;

  @override
  void initState() {
    // Init Person
    ctrlPatientId = TextEditingController(text: widget.patient.patientId);
    ctrlName = TextEditingController(text: widget.patient.name);
    ctrlLastName = TextEditingController(text: widget.patient.lastName);
    ctrlAge = TextEditingController(text: widget.patient.age);
    ctrlAddress = TextEditingController(text: widget.patient.address);
    ctrlNeighborhood = TextEditingController(text: widget.patient.neighborhood);
    ctrlPhone = TextEditingController(text: widget.patient.phone);
    ctrlCity = TextEditingController(text: widget.patient.city);

    statusTxt = widget.patient.status;
    widget.patient.status == 'Active' ? isActive = true : isActive = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar paciente'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: ListView(
          children: [
            SizedBox(
              height: 5.0,
            ),
            MyTextField(myController: ctrlPatientId, myLabel: 'Identificacion'),
            MyTextField(myController: ctrlName, myLabel: 'Nombres'),
            MyTextField(myController: ctrlLastName, myLabel: 'Apellidos'),
            MyTextField(myController: ctrlAge, myLabel: 'Edad'),
            MyTextField(myController: ctrlAddress, myLabel: 'Direccion'),
            MyTextField(myController: ctrlNeighborhood, myLabel: 'Barrio'),
            MyTextField(myController: ctrlPhone, myLabel: 'Telefono'),
            MyTextField(myController: ctrlCity, myLabel: 'Ciudad'),
            SwitchListTile(
              title: Text('Activar paciente?'),
              value: isActive,
              onChanged: (bool value) {
                setState(() {
                  isActive = value;
                });
              },
            ),
            ButtonGeneric(
              title: 'Confirmar',
              onPressed: () {
                statusTxt = isActive == true ? 'Active' : 'Inactive';
                Patient patient = Patient(
                  patientId: ctrlPatientId.text,
                  status: statusTxt,
                  name: ctrlName.text,
                  lastName: ctrlLastName.text,
                  photo: 'Sinfoto',
                  age: ctrlAge.text,
                  address: ctrlAddress.text,
                  neighborhood: ctrlNeighborhood.text,
                  phone: ctrlPhone.text,
                  city: ctrlCity.text,
                );

                modifyPatient(patient).then((patient) {
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
