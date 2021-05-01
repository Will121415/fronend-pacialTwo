import 'package:flutter/material.dart';

messageResponde(BuildContext context, String _content) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text('MENSAJE INFORMATIVO'),
            backgroundColor: Colors.amber,
            content: Text(_content,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ));
}
