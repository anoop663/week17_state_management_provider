class StudentModel {
  String name;

  String age;

  String phone;

  String roll;

  int? id;
  StudentModel(
      {required this.name,
      required this.age,
      required this.phone,
      required this.roll,
      this.id});
  static StudentModel fromMap(Map<String, Object?> map) {
    final name = map['name'] as String;
    final age = map['age'] as String;
    final phone = map['phone'] as String;
    final roll = map['roll'] as String;
    final id = map['id'] as int?;
    return StudentModel(name: name, age: age, phone: phone, roll: roll, id: id);
  }
}
