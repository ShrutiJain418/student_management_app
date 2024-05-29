// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/student/student_bloc.dart';
import '../models/student.dart';
import 'update_student_screen.dart';

class StudentsListScreen extends StatefulWidget {
  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentsLoaded) {
          final sortedStudents = state.students.toList()
            ..sort((a, b) => a.name.compareTo(b.name));

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              // ignore: prefer_const_literals_to_create_immutables
              columns: [
                DataColumn(
                    label: Text('Name',
                        style: TextStyle(color: Colors.white, fontSize: 16.0))),
                DataColumn(
                    label: Text('Gender',
                        style: TextStyle(color: Colors.white, fontSize: 16.0))),
                DataColumn(
                    label: Text('Date of Birth',
                        style: TextStyle(color: Colors.white, fontSize: 16.0))),
              ],
              rows: sortedStudents.map((student) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(student.name, style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UpdateStudentScreen(student: student),
                        ));
                      },
                    ),
                    DataCell(
                      Text(student.gender,
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UpdateStudentScreen(student: student),
                        ));
                      },
                    ),
                    DataCell(
                      Text(student.dob.toLocal().toString().split(' ')[0],
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UpdateStudentScreen(student: student),
                        ));
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
