import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final myLabel;
  const MyTextField({
    this.myLabel,
    Key key,
    @required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 15, left: 15),
      child: TextField(
        controller: this.myController,
        decoration: InputDecoration(
            labelText: this.myLabel,
            suffix: GestureDetector(
              child: Icon(Icons.close),
              onTap: () {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => myController.clear());
              },
            )),
      ),
    );
  }
}
