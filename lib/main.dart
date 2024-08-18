import 'package:flutter/material.dart';
import 'package:project_fourth/db/functions/db_functions.dart';
import 'package:project_fourth/screens/widgets/add_student_widget.dart';


Future<void> main() async {
    DataBaseFunctions dataBaseFunctions = DataBaseFunctions();
  await dataBaseFunctions.initializeDataBase();
  runApp(const FourthApp());
}

class FourthApp extends StatelessWidget {
  const FourthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  AddStudentWidget(),
    );
  }
}
