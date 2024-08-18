import 'package:flutter/material.dart';
import 'package:project_fourth/db/functions/db_functions.dart';

// ignore: must_be_immutable
class AlertPopup extends StatelessWidget {
  DataBaseFunctions dataBaseFunctions = DataBaseFunctions();
  final int itemId;
  final VoidCallback onDeleted; // Added this parameter

   AlertPopup({super.key, required this.itemId, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Data"),
      content: const Text("Are you sure you want to delete this student?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            dataBaseFunctions.deleteStudents(itemId); // Ensure this function is defined and works properly
            // Call this callback after deletion
            Navigator.of(context).pop();
             onDeleted();
          },
          child: const Text("Continue"),
        ),
      ],
    );
  }
}
