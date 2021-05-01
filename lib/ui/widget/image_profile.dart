import 'package:flutter/material.dart';

class ImageProfile extends StatelessWidget {
  // String urlImage;
  // ImageProfile(this.urlImage);
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
          // child: Image.network(urlImage),
        ),
      ),
    );
  }
}
