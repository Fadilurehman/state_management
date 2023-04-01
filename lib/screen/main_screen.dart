import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider/student_provider.dart';
import 'package:flutter_application_1/screen/add_student.dart';
import 'package:flutter_application_1/screen/edit_students.dart';
import 'package:flutter_application_1/screen/full_list.dart';
import 'package:flutter_application_1/screen/search_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentProvider>(context, listen: false).getAllStudents();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students List',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchStudentList(),
                  ));
            },
            icon: const Icon(Icons.search),
            tooltip: 'open search ',
          ),
        ],
      ),
      body: SafeArea(
        // create listenable builder
        child: Consumer<StudentProvider>(builder: (context, provider, child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final data = provider.studentList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullDetails(
                            name: data.name,
                            age: data.age,
                            class_: data.class_,
                            rollno: data.rollnumber,
                            photo: data.photo,
                          ),
                        ),
                      );
                    },
                    title: Text(data.name.toUpperCase(),
                        style: const TextStyle(fontSize: 15)),
                    leading: data.photo == null
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage('Assets/images/avatar (1).png'),
                            radius: 30,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(
                              File(data.photo!),
                            ),
                            radius: 30,
                          ),

                    // const CircleAvatar(
                    //   // backgroundImage: data.photo == null ? AssetImage('Assets/images/avatar (1).png'): File(data.photo!),

                    //   radius: 30,
                    // ),

                    trailing: Wrap(
                      spacing: 14,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditStudent(
                                    name: data.name,
                                    class_: data.class_,
                                    age: data.age,
                                    rollno: data.rollnumber,
                                    index: index,
                                    photo: data.photo,
                                  );
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.blue,
                        ),
                        IconButton(
                          onPressed: () {
                            // deleteList(index);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                        'alert!!',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      content: const Text(
                                          'do you really want to delete this student '),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            provider.deleteList(index);
                                            popoutfunction(context);
                                          },
                                          child: const Text(
                                            'yes',
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            popoutfunction(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    ));
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: provider.studentList.length);
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudent(),
            ),
          );
        },
        label: const Text('Add New Student'),
      ),
    );
  }

  popoutfunction(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
