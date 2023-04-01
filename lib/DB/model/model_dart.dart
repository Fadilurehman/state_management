import 'package:hive_flutter/adapters.dart';
part 'model_dart.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String rollnumber;

  @HiveField(3)
  final String class_;

  @HiveField(4)
  int? id;

  @HiveField(5)
  final String? photo;

  StudentModel({required this.name, required this.age, required this.rollnumber, required this.class_, required this.photo, this.id});
}
