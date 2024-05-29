part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentsLoading extends StudentState {}

class StudentsLoaded extends StudentState {
  final List<Student> students;

  const StudentsLoaded(this.students);

  @override
  List<Object> get props => [students];
}

class StudentsLoadFailure extends StudentState {
  final String error;

  const StudentsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
