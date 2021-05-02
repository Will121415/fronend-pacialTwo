import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/repository/patient_repository.dart';
import 'package:parcial_two/ui/widget/button_generic.dart';
import 'package:parcial_two/ui/widget/text_field.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
  TextEditingController ctrlAge;
  TextEditingController ctrlAddress;
  TextEditingController ctrlNeighborhood;
  TextEditingController ctrlPhone;
  TextEditingController ctrlCity;
  String photo;
  File imageFile;
  Uint8List imageUint8List;

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
    photo = widget.patient.photo;
    imageUint8List = Base64Codec().decode(widget.patient.photo);
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
            imagenSelect(context),
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
                  photo: imageFile == null ? photo : imageToBase64(imageFile),
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

  imagenSelect(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      height: 200.0,
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _showChoiceDialog(context),
            child: Container(
              child: Image.memory(
                imageUint8List,
                fit: BoxFit.fill,
              ),
              width: 360,
            ),
          ),
        ],
      ),
    );
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
                  SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                      onTap: () {
                        _openGallery(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.photo_library),
                          Text('  Elegir photo de la galeria'),
                        ],
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                      onTap: () {
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

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      loadImage(picture.path);
    });
    Navigator.of(context).pop();
  }

  loadImage(String path) {
    imageFile = File(path);
    imageUint8List = Base64Codec().decode(imageToBase64(imageFile));
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      loadImage(picture.path);
    });

    Navigator.of(context).pop();
  }

  imageToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }
}
