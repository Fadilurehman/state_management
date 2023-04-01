import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:flutter_application_1/controller/provider/student_provider.dart';
import 'package:flutter_application_1/screen/widgets/editstudent.dart';
import 'package:provider/provider.dart';

class EditStudent extends StatelessWidget {
  final String name;

  final String class_;

  final String age;

  final String rollno;

  final int index;

  final String? photo;

  const EditStudent({
    super.key,
    required this.name,
    required this.class_,
    required this.age,
    required this.rollno,
    required this.index,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: SafeArea(
        child: EditListView(
          name: name,
          class_: class_,
          age: age,
          rollno: rollno,
          photo: photo,
          index: index,
        ),
      ),
    );
  }
}

Future<void> editSave(BuildContext context, index) async {
  final provider = Provider.of<StudentProvider>(context, listen: false);
  final student = StudentModel(
    name: provider.enameController.text,
    age: provider.eageController.text,
    rollnumber: provider.erollNoController.text,
    class_: provider.eclassController.text,
    photo: provider.fileimage?.path ?? provider.eprofile,
  );

  provider.editList(index, student);
  provider.eprofile == null;
}
