import 'package:flutter/material.dart';



Future<void> showEmailVerificationDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Reminder",
            textAlign: TextAlign.center,
          ),
          content: Text(
            text,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK",
                style: TextStyle(fontSize: 18),),
                )
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actionsAlignment: MainAxisAlignment.center,
        );
      });
}
