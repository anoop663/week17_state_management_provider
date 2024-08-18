import 'package:flutter/material.dart';
import 'package:project_fourth/db/models/data_model.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseFunctions {
  late Database _db;

  Future<void> initializeDataBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    _db = await openDatabase(
      'student_db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, phone TEXT, roll TEXT)');
      },
    );
  }

  Future<void> addStudentToDatabase(StudentModel value) async {
    await _db.rawInsert(
      'INSERT INTO student (name,age,phone,roll) VALUES(?,?,?,?)',
      [value.name, value.age, value.phone, value.roll],
    );
  }

  Future<List<StudentModel>> getAllStudents() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _values = await _db.rawQuery('SELECT * FROM student');
    return _values.map((map) => StudentModel.fromMap(map)).toList();
  }

  Future<void> deleteStudents(int id) async {
    try {
      await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting student: $e');
    }
  }
}
