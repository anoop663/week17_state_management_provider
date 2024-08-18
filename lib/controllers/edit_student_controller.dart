import 'package:flutter/material.dart';
import 'package:project_fourth/db/functions/db_functions.dart';
import 'package:sqflite/sqflite.dart';

class EditStudentController extends ChangeNotifier {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController phoneController;
  late TextEditingController rollController;
  DataBaseFunctions dataBaseFunctions = DataBaseFunctions();

  final int id;
  late Database _db;

  EditStudentController(this.id) {
    nameController = TextEditingController();
    ageController = TextEditingController();
    phoneController = TextEditingController();
    rollController = TextEditingController();

    _initialize();
  }

  Future<void> _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    _db = await openDatabase(
      'student_db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, phone TEXT, roll TEXT)',
        );
      },
    );
    await _loadData();
  }

  Future<void> _loadData() async {
    try {
      final List<Map<String, dynamic>> maps = await _db.query(
        'student',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        nameController.text = maps[0]['name'];
        ageController.text = maps[0]['age'];
        phoneController.text = maps[0]['phone'];
        rollController.text = maps[0]['roll'];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error retrieving data: $e');
    }
  }

  Future<void> updateUserData() async {
    try {
      await _db.update(
        'student',
        {
          'name': nameController.text,
          'age': ageController.text,
          'phone': phoneController.text,
          'roll': rollController.text,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      await dataBaseFunctions.getAllStudents();
      notifyListeners();
    } catch (e) {
            // ignore: avoid_print
      print('Error updating data: $e');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    rollController.dispose();
    super.dispose();
  }
}
