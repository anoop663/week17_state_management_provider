import 'package:flutter/material.dart';
import 'package:project_fourth/controllers/edit_student_controller.dart';
import 'package:provider/provider.dart';


class EditUserDataPage2 extends StatelessWidget {
  final int idvalue;
  final VoidCallback refreshCallback;

  // ignore: use_super_parameters
  const EditUserDataPage2({Key? key, required this.idvalue, required this.refreshCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditStudentController(idvalue),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student Data'),
        ),
        body: Consumer<EditStudentController>(
          builder: (context, controller, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Name'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.ageController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.phoneController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.rollController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Roll Number'),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () async {
                      await controller.updateUserData();
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, true); 
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
