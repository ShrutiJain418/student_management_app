import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/student.dart';
import '../../repositories/firestore_repository.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final FirestoreRepository firestoreRepository;

  StudentBloc({required this.firestoreRepository}) : super(StudentInitial()) {
    on<LoadStudents>(_onLoadStudents);
    on<StudentsUpdated>(_onStudentsUpdated);
    on<AddStudent>(_onAddStudent);
    on<UpdateStudent>(_onUpdateStudent);

    firestoreRepository.studentStream().listen((students) {
      add(StudentsUpdated(students));
    });
  }

  void _onLoadStudents(LoadStudents event, Emitter<StudentState> emit) async {
    emit(StudentsLoading());
    try {
      final students = await firestoreRepository.fetchStudents();
      emit(StudentsLoaded(students));
    } catch (error) {
      emit(StudentsLoadFailure(error.toString()));
    }
  }

  void _onStudentsUpdated(StudentsUpdated event, Emitter<StudentState> emit) {
    emit(StudentsLoaded(event.students));
  }

  void _onAddStudent(AddStudent event, Emitter<StudentState> emit) async {
    try {
      await firestoreRepository.addStudent(event.student);
    } catch (error) {
      emit(StudentsLoadFailure(error.toString()));
    }
  }

  void _onUpdateStudent(UpdateStudent event, Emitter<StudentState> emit) async {
    try {
      await firestoreRepository.updateStudent(event.student);
      final students = await firestoreRepository.fetchStudents();
      emit(StudentsLoaded(students));
    } catch (error) {
      emit(StudentsLoadFailure(error.toString()));
    }
  }
}
