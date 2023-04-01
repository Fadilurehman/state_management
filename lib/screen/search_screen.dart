import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider/student_provider.dart';

import 'package:flutter_application_1/screen/edit_students.dart';

import 'package:flutter_application_1/screen/full_list.dart';

import 'package:provider/provider.dart';

class SearchStudentList extends StatelessWidget {
  const SearchStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentProvider>(context, listen: false).searchResults();
    });
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Consumer<StudentProvider>(
                  builder: (context, provider, child) {
                    return CupertinoSearchTextField(
                      onChanged: (value) {
                        provider.updateList(value);
                      },
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.all(12),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      suffixIcon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              Consumer<StudentProvider>(builder: (context, value, child) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = value.searchdata[index];
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
                                  backgroundImage: AssetImage(
                                      'Assets/images/avatar (1).png'),
                                  radius: 30,
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(data.photo!),
                                  ),
                                  radius: 30,
                                ),
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
                                                  value.deleteList(index);
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
                    itemCount: value.searchdata.length);
              })
            ],
          );
        }),
      ),
    );
  }

  popoutfunction(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
