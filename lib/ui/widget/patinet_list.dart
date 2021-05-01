import 'package:flutter/material.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/repository/patient_repository.dart';

class PatientList extends StatefulWidget {
  final List<Patient> patients;
  PatientList(this.patients);
  ImageProvider image;

  @override
  State<StatefulWidget> createState() => _PatientList();
}

class _PatientList extends State<PatientList> {
  List<Patient> patients;

  @override
  void initState() {
    patients = widget.patients;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: patients == null ? 0 : patients.length,
        itemBuilder: (context, posicion) {
          return ListTile(
              onTap: () {},
              leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  backgroundImage: widget.image,
                  radius: 30.0,
                  child: Text(
                    patients[posicion].name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              title: Text(patients[posicion].name),
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
              //this._usuarios.remove(user);
              deletePatient(patient.patientId).then((value) {
                if (value.patientId != '') {
                  setState(() {
                    print(value);
                  });
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
}
