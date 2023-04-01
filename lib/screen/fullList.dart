import 'dart:io';

import 'package:flutter/material.dart';

class FullDetails extends StatelessWidget {
  final String name;
  final String class_;

  final String age;

  final String rollno;

  final String? photo;

  const FullDetails({
    super.key,
    required this.name,
    required this.age,
    required this.class_,
    required this.rollno,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: const Text('Full Details'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: photo == null
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage('Assets/images/avatar (1).png'),
                            radius: 80,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(
                              File(photo!),
                            ),
                            radius: 80,
                          ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Text(
                        'NAME :  $name'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Text(
                        'CLASS :  $class_',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Text(
                        'AGE : $age',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Text(
                        'ROLL NO : $rollno',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
