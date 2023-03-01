import 'package:flutter/material.dart';

class GlobalMethode {
  static Future<void> warningDialog(
      {required String title,
      required String subtitle,
      required Function fct,
      required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 24,
                  width: 24,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 6),
                Text(title)
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    fct();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }
}
