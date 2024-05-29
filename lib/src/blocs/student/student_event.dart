part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class LoadStudents extends StudentEvent {}

class StudentsUpdated extends StudentEvent {
  final List<Student> students;

  const StudentsUpdated(this.students);

  @override
  List<Object> get props => [students];
}

class AddStudent extends StudentEvent {
  final Student student;

  const AddStudent(this.student);

  @override
  List<Object> get props => [student];
}

class UpdateStudent extends StudentEvent {
  final Student student;

  const UpdateStudent(this.student);

  @override
  List<Object> get props => [student];
}
