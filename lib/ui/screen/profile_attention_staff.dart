import 'package:flutter/material.dart';
import 'package:parcial_two/model/attention_staff_model.dart';
import 'package:parcial_two/ui/screen/attention_staff_modify_screen.dart';
import 'package:parcial_two/ui/widget/image_profile.dart';
import 'package:parcial_two/ui/widget/info_profile_attention_staff.dart';
import 'package:parcial_two/ui/widget/message_response.dart';

class ProfileAttentionStaff extends StatefulWidget {
  final AttentionStaff staff;
  ProfileAttentionStaff({Key key, this.staff});
  @override
  State<StatefulWidget> createState() => _ProfileAttentionStaff();
}

class _ProfileAttentionStaff extends State<ProfileAttentionStaff> {
  AttentionStaff staff;

  @override
  void initState() {
    staff = widget.staff;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del personal de atencion ' + staff.name),
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
                  ImageProfile(staff.photo),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 55.0, left: 5.0, right: 5.0),
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
                                                  AttentionStaffModify(
                                                    staff: staff,
                                                  ))).then((value) {
                                        if (value != null) {
                                          setState(() {
                                            staff = value;
                                            messageResponde(context,
                                                'El personal de atencion ${value.name} a sido modificado');
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
