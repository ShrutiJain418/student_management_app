import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String name;
  final DateTime dob;
  final String gender;

  Student({
    required this.id,
    required this.name,
    required this.dob,
    required this.gender,
  });

  factory Student.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Student(
      id: doc.id,
      name: data['name'] ?? '', // Add null check to prevent null error
      dob: _parseDate(data['dob']), // Parse dob based on its actual type
      gender: data['gender'] ?? '', // Add null check to prevent null error
    );
  }

  static DateTime _parseDate(dynamic date) {
    if (date is Timestamp) {
      // If it's a Timestamp, convert it to DateTime
      return date.toDate();
    } else if (date is String) {
      // If it's a String, parse it to DateTime
      return DateTime.parse(date);
    } else {
      // Handle other types or null by returning current date
      return DateTime.now();
    }
  }
}
