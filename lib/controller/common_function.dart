import 'package:flutter/material.dart';

class CommonFunction{

  showWarningDialog(msg,context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Warning!'),
        content: Text(msg),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: const Text('Ok'))
        ],
      );
    });
  }
}