import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parcial_two/model/attention_staff_model.dart';
import 'package:parcial_two/model/user_model.dart';
import 'package:parcial_two/repository/attention_staff_repository.dart';
import 'package:parcial_two/ui/widget/button_generic.dart';
import 'package:parcial_two/ui/widget/text_field.dart';
import 'package:image_picker/image_picker.dart';

class AttentionStaffRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AttentionStaffRegister();
}

class _AttentionStaffRegister extends State<AttentionStaffRegister> {
  //Controllers
  TextEditingController ctrlAttentionId;
  TextEditingController ctrlName;
  TextEditingController ctrlLastName;
  TextEditingController ctrlType;
  TextEditingController ctrlPhoto;
  TextEditingController ctrlServiceStatus;
  TextEditingController ctrlUserName;
  TextEditingController ctrlPassword;

  File imagen;

  @override
  void initState() {
    // Init Person
    ctrlAttentionId = TextEditingController();
    ctrlName = TextEditingController();
    ctrlLastName = TextEditingController();
    ctrlType = TextEditingController();
    ctrlPhoto = TextEditingController();
    ctrlServiceStatus = TextEditingController();
    ctrlUserName = TextEditingController();
    ctrlPassword = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
              myController: ctrlAttentionId,
              myLabel: 'Identificacion',
            ),
            MyTextField(
              myController: ctrlName,
              myLabel: 'Nombres',
            ),
            MyTextField(myController: ctrlLastName, myLabel: 'Apellidos'),
            MyTextField(myController: ctrlType, myLabel: 'Tipo'),
            MyTextField(myController: ctrlUserName, myLabel: 'Usuario'),
            MyTextField(myController: ctrlPassword, myLabel: 'Contraseña'),
            ButtonGeneric(
              title: 'Guardar',
              onPressed: () {
                User _user = new User(
                    userName: ctrlUserName.text,
                    password: ctrlPassword.text,
                    status: 'Active',
                    role: 'AttentionStaff');
                AttentionStaff staff = AttentionStaff(
                  attentionId: ctrlAttentionId.text,
                  name: ctrlName.text,
                  lastName: ctrlLastName.text,
                  type: ctrlType.text,
                  photo: imagen == null ? null : imageToBase64(imagen),
                  serviceStatus: 'avaliable',
                  user: _user,
                );

                addStaff(staff).then((staff) {
                  if (staff.attentionId != '') {
                    Navigator.pop(context, staff);
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
    return Container(
      padding: EdgeInsets.all(5.0),
      height: 200.0,
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _showChoiceDialog(context);
            },
            child: Container(
              child: Image(
                image: (imagen != null)
                    ? FileImage(imagen, scale: 0.1)
                    : AssetImage('assets/No_image.png'),
                fit: BoxFit.fill,
              ),
              width: 360,
            ),
          ),
        ],
      ),
    );
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    if (picture.path != null) {
      this.setState(() {
        imagen = File(picture.path);
      });
    }
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imagen = File(picture.path);
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
