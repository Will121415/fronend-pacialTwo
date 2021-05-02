import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/repository/patient_repository.dart';
import 'package:parcial_two/ui/widget/button_generic.dart';
import 'package:parcial_two/ui/widget/text_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

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
  File Imagen;

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
            imagenSelect(context),
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
                  photo: Imagen==null?null:imageToBase64(Imagen),
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

  imagenSelect(context) {
    return RaisedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _showChoiceDialog(context);
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Image(
                image: Imagen != null
                    ? FileImage(Imagen, scale: 0.1)
                    : AssetImage('assets/No_image.png'),
                fit: BoxFit.cover,
                height: 180,
                width: 280,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      Imagen = File(picture.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      Imagen = File(picture.path);
    });

    Navigator.of(context).pop();
  }

  _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text("Elegir foto"),
              content: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        _openGallery(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.photo_library),
                          Text('  Elegir photo de la galeria'),
                        ],
                      )),
                  FlatButton(
                      onPressed: () {
                        _openCamera(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt_sharp),
                          Text('  Haz una foto'),
                        ],
                      ))
                ],
              )));
        });
  }

  imageToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }
}
