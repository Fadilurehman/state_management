import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:hive_flutter/adapters.dart';

// create list of a student model

ValueNotifier<List<StudentModel>> studentList = ValueNotifier([]);

// functions to add student model

// button click

Future<void> addStudent(StudentModel value) async {
  // open box
  final studentsDB = await Hive.openBox<StudentModel>('students_db');

  final id = await studentsDB.add(value);

  value.id = id;

  studentList.value.add(value);

  studentList.notifyListeners();
  getAllStudents();
}

Future<void> getAllStudents() async {
  final studentsDB = await Hive.openBox<StudentModel>('students_db');

  studentList.value.clear();

  studentList.value.addAll(studentsDB.values);

  studentList.notifyListeners();
}

Future<void> deleteList(int index) async {
  final studentsDB = await Hive.openBox<StudentModel>('students_db');

  await studentsDB.deleteAt(index);

  getAllStudents();
}

Future<void> editList(int index, StudentModel student) async {
  final studentDb = await Hive.openBox<StudentModel>('students_db');
  studentDb.putAt(index, student);
  getAllStudents();
}
