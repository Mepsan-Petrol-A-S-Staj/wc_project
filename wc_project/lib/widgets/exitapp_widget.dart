import 'package:flutter/material.dart';

class ExitAppWidget {
  static Future<dynamic> exitAppShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Uygulamadan çıkış yapamazsınız.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }
}
