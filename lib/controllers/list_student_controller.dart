import 'package:flutter/material.dart';
import 'package:project_fourth/db/functions/db_functions.dart';
import 'package:project_fourth/db/models/data_model.dart';

class ListStudentController extends ChangeNotifier {
  List<StudentModel> _studentList = [];
  bool _isGridView = false;
  final TextEditingController searchController = TextEditingController();
  DataBaseFunctions dataBaseFunctions = DataBaseFunctions();

  List<StudentModel> get studentList => _studentList;
  bool get isGridView => _isGridView;
  String get searchQuery => searchController.text;

  ListStudentController() {
    _fetchAllStudents();
    searchController.addListener(() {
      notifyListeners();
    });
  }

  Future<void> _fetchAllStudents() async {
    _studentList = await dataBaseFunctions.getAllStudents();
    notifyListeners();
  }

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    notifyListeners();
  }

  void searchQueryChanged(String query) {
    notifyListeners();
  }

  Future<void> refreshList() async {
    await _fetchAllStudents();
  }

  Future<void> addStudent(StudentModel student) async {
    await dataBaseFunctions.addStudentToDatabase(student);
    await _fetchAllStudents();
  }

  Future<void> deleteStudent(int id) async {
    await dataBaseFunctions.deleteStudents(id);
    await _fetchAllStudents();
  }

  List<StudentModel> get filteredStudentList {
    final searchQueryLower = searchQuery.toLowerCase();
    return _studentList.where((student) {
      final nameLower = student.name.toLowerCase();
      return nameLower.contains(searchQueryLower);
    }).toList();
  }
}
