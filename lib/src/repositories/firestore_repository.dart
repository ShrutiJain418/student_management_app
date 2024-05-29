import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Student>> studentStream() {
    return _firestore.collection('students').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Student.fromSnapshot(doc);
      }).toList();
    });
  }

  Future<List<Student>> fetchStudents() async {
    final querySnapshot = await _firestore.collection('students').get();
    return querySnapshot.docs.map((doc) => Student.fromSnapshot(doc)).toList();
  }

  Future<void> addStudent(Student student) async {
    await _firestore.collection('students').add({
      'name': student.name,
      'dob': student.dob,
      'gender': student.gender,
    });
  }

  Future<void> updateStudent(Student student) async {
    try {
      await _firestore.collection('students').doc(student.id).update({
        'name': student.name,
        'dob': student.dob,
        'gender': student.gender,
      });
    } catch (e) {
      print('Error updating student: $e');
    }
  }
}
