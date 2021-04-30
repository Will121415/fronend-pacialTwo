import 'package:flutter/material.dart';

class ButtonGeneric extends StatefulWidget {
  final String title;
  double height, width;
  VoidCallback onPressed;
  // IconData icon;

  ButtonGeneric({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.height,
    this.width,
    // this.icon
  });
  @override
  State<StatefulWidget> createState() => _ButtonGeneric();
}

class _ButtonGeneric extends State<ButtonGeneric> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.blue,
          gradient: LinearGradient(
              colors: [Color(0xFFFBC23F), Color(0xFF01BCCF)],
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 0.6),
              stops: [0.0, 0.6],
              tileMode: TileMode.clamp)),
      child: InkWell(
        onTap: widget.onPressed,
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
          ),
        ),
      ),
    );
  }
}
