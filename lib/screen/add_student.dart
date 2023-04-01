import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:flutter_application_1/controller/provider/student_provider.dart';
import 'package:provider/provider.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<StudentProvider>(builder: (context, provider, child) {
          return Form(
            key: provider.mainFormKey,
            child: Column(
              children: [
                const SizedBox(height: 70),
                Container(
                  child: provider.fileimage == null
                      ? Container(
                          height: 140,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('Assets/images/avatar (1).png'),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(
                            File(provider.fileimage!.path),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        provider.imageFromGallery();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Profile')),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: provider.nameStudentController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 2,
                    controller: provider.classStudentController,
                    decoration: const InputDecoration(
                      hintText: 'class',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    controller: provider.ageStudentController,
                    decoration: const InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 4,
                    controller: provider.rollStudentController,
                    decoration: const InputDecoration(
                      hintText: 'roll no',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // onAddStudents(context);

                        if (provider.mainFormKey.currentState!.validate()) {
                          onAddStudents(context);
                          Navigator.of(context).pop();
                          provider.ageStudentController.clear();
                          provider.classStudentController.clear();
                          provider.nameStudentController.clear();
                          provider.rollStudentController.clear();
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add This Details'),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> onAddStudents(BuildContext context) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final name = provider.nameStudentController.text.trim();

    final age = provider.ageStudentController.text.trim();

    final rollNo = provider.rollStudentController.text.trim();

    final class_ = provider.classStudentController.text.trim();

    if (name.isEmpty || age.isEmpty || rollNo.isEmpty || class_.isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          width: 150,
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          content: Text('New Data Added'),
        ),
      );
    }

    // create student model
    final providers = Provider.of<StudentProvider>(context, listen: false);
    final student = StudentModel(
        name: name,
        age: age,
        class_: class_,
        rollnumber: rollNo,
        photo: providers.fileimage?.path);

    providers.addStudent(student);
    providers.fileimage = null;
    // log('data added success');
  }
}
