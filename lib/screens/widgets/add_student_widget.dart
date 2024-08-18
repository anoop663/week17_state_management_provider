import 'package:flutter/material.dart';
import 'package:project_fourth/controllers/add_student_controller.dart';
import 'package:project_fourth/db/functions/db_functions.dart';
import 'package:project_fourth/db/models/data_model.dart';

// ignore: must_be_immutable
class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({super.key, Key? key1});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _rollController = TextEditingController();
  AddStudentController addStudentController = AddStudentController();
  DataBaseFunctions dataBaseFunctions = DataBaseFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              addStudentController.showUserProfileDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Age is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _rollController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Roll Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Roll number is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          onAddStudentButtonClicked(context);
                        },
                        child: const Text('Add Information'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          addStudentController.navigateToNextScreen(context);
                        },
                        child: const Text('View Student List'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final age = _ageController.text.trim();
      final phone = _phoneController.text.trim();
      final roll = _rollController.text.trim();

      final student = StudentModel(
        name: name,
        age: age,
        phone: phone,
        roll: roll,
      );

      dataBaseFunctions.addStudentToDatabase(student);

      _nameController.clear();
      _ageController.clear();
      _phoneController.clear();
      _rollController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student information added successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields correctly'),
        ),
      );
    }
  }
}
