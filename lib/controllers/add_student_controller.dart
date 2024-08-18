import 'dart:io';
import 'package:project_fourth/screens/widgets/list_student_widget.dart';
import 'package:flutter/material.dart';

class AddStudentController {
  void navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListStudentWidget()),
    );
  }

  void showUserProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Profile'),
          content: SizedBox(
            height: 150,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text('User1'),
                  subtitle: const Text('Admin User'),
                  leading: Image.network(
                      'https://www.shutterstock.com/image-vector/young-smiling-man-avatar-brown-600nw-2261401207.jpg'),
                  trailing: IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      Navigator.pop(context);
                      confirmExit(context);
                    },
                  ),
                ),
                const Divider(color: Colors.black),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Exit"),
          content: const Text("Are you sure you want to exit?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                if (Platform.isAndroid || Platform.isIOS) {
                  exit(0);
                }
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  
}
