import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageProfile extends StatelessWidget {
  String _image;
  ImageProfile(this._image);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -50,
      left: (MediaQuery.of(context).size.width / 2) - 64,
      child: Container(
        height: 100,
        width: 100,
        color: Colors.blue,
        child: Card(
          elevation: 2,
          child: Image.memory(
            base64ToImage(_image),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Uint8List base64ToImage(String base64Image) {
    return Base64Codec().decode(base64Image);
  }
}
