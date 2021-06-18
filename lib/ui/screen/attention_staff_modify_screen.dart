import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:parcial_two/model/attention_staff_model.dart';
import 'package:parcial_two/model/user_model.dart';
import 'package:parcial_two/repository/attention_staff_repository.dart';
import 'package:parcial_two/ui/widget/button_generic.dart';
import 'package:parcial_two/ui/widget/text_field.dart';
import 'package:image_picker/image_picker.dart';

class AttentionStaffModify extends StatefulWidget {
  final AttentionStaff staff;
  AttentionStaffModify({Key key, this.staff});
  @override
  State<StatefulWidget> createState() => _AttentionStaffModify();
}

class _AttentionStaffModify extends State<AttentionStaffModify> {
  //Controllers
  TextEditingController ctrlAttentionId;
  TextEditingController ctrlName;
  TextEditingController ctrlLastName;
  TextEditingController ctrlType;
  TextEditingController ctrlPhoto;
  TextEditingController ctrlServiceStatus;
  TextEditingController ctrlUserName;
  TextEditingController ctrlPassword;

  String photo;
  File imageFile;
  Uint8List imageUint8List;

  bool isAvailable;
  String statusTxt;

  @override
  void initState() {
    // Init Person
    ctrlAttentionId = TextEditingController(text: widget.staff.attentionId);
    ctrlName = TextEditingController(text: widget.staff.name);
    ctrlLastName = TextEditingController(text: widget.staff.lastName);
    ctrlType = TextEditingController(text: widget.staff.type);
    ctrlUserName = TextEditingController(text: widget.staff.user.userName);
    ctrlPassword = TextEditingController(text: widget.staff.user.password);

    photo = widget.staff.photo;
    imageUint8List = Base64Codec().decode(widget.staff.photo);
    statusTxt = widget.staff.serviceStatus;
    isAvailable = widget.staff.serviceStatus == 'available' ? true : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Modicicar personal de atencion'),
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
            SwitchListTile(
              title: Text('Esta disponible?'),
              value: isAvailable,
              onChanged: (bool value) {
                setState(() {
                  isAvailable = value;
                });
              },
            ),
            ButtonGeneric(
              title: 'Confirmar',
              onPressed: () {
                statusTxt = isAvailable == true ? 'available' : 'occupied';
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
                  photo: imageFile == null ? photo : imageToBase64(imageFile),
                  serviceStatus: statusTxt,
                  user: _user,
                );

                print(staff.serviceStatus);

                modifyStaff(staff).then((staff) {
                  if (staff.attentionId != '') {
                    print(staff.attentionId);
                    print(staff.name);
                    print(staff.type);
                    print(staff.lastName);
                    print(staff.serviceStatus);
                    print(staff.user.userName);
                    print(staff.user.password);
                    print(staff.user.role);
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

  imageToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }
}
