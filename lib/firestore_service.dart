import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addQuizData() async {
    // Menambahkan dokumen quiz
    await _db.collection('quizzes').doc('quiz1').set({
      'title': 'Quiz Bahasa Indonesia',
      'description': 'Test your knowledge of Indonesian language',
    });

    // Menambahkan pertanyaan ke subkoleksi questions
    await _db
        .collection('quizzes')
        .doc('quiz1')
        .collection('questions')
        .doc('q1')
        .set({
      'questionText': 'Apa ibukota Indonesia?',
      'answers': ['Jakarta', 'Bandung', 'Surabaya', 'Medan'],
      'correctAnswerIndex': 0,
    });

    await _db
        .collection('quizzes')
        .doc('quiz1')
        .collection('questions')
        .doc('q2')
        .set({
      'questionText': 'Apa bahasa resmi Indonesia?',
      'answers': ['Sunda', 'Jawa', 'Indonesia', 'Melayu'],
      'correctAnswerIndex': 2,
    });
  }
}
