import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizPage extends StatefulWidget {
  final String quizId;

  QuizPage({required this.quizId});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  List<int?> _selectedAnswers = [];
  int _score = 0;
  List<Question> _questions = [];
  bool _isLoading = true;
  String _error = "";

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    print("Fetching questions for quizId: ${widget.quizId}");
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('quizzes')
          .doc(widget.quizId)
          .collection('questions')
          .get();

      List<Question> questions = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print("Data fetched from Firestore: $data");

        // Ensure data is not null and has the expected type
        if (data['questionText'] is String &&
            data['answers'] is List<dynamic> &&
            data['correctAnswerIndex'] is int) {
          return Question(
            questionText: data['questionText'] ?? '',
            answers: List<String>.from(data['answers'] ?? []),
            correctAnswerIndex: data['correctAnswerIndex'] ?? 0,
          );
        } else {
          throw Exception('Invalid data format');
        }
      }).toList();

      setState(() {
        _questions = questions;
        _isLoading = false;
        print("Fetched ${questions.length} questions.");
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
        print("Error fetching questions: $e");
      });
    }
  }

  void _submitAnswer(int answerIndex) async {
    setState(() {
      _selectedAnswers.add(answerIndex);
      if (answerIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _saveQuizResult();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  size: 60.0,
                  color: Colors.yellow,
                ),
                SizedBox(width: 16.0),
                Text(
                  'Hasil Kuis',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Skor Anda: $_score/${_questions.length}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                if (_score == _questions.length)
                  Text(
                    'Selamat! Anda menjawab semua pertanyaan dengan benar.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tutup',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  void _saveQuizResult() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      await userDoc.collection('quiz_results').doc(widget.quizId).set({
        'quizId': widget.quizId,
        'score': _score,
        'totalQuestions': _questions.length,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (_score == _questions.length) {
        await userDoc.update({
          'progress.${widget.quizId}': true,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Center(
          child: Text('Error: $_error'),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Center(
          child: Text('No questions found'),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pertanyaan ${_currentQuestionIndex + 1}/${_questions.length}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  question.questionText,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox(height: 20.0),
              ...List.generate(question.answers.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      question.answers[index],
                      style: TextStyle(fontSize: 16.0), // Adjust font size
                    ),
                    leading: Radio<int>(
                      value: index,
                      groupValue:
                          _selectedAnswers.length > _currentQuestionIndex
                              ? _selectedAnswers[_currentQuestionIndex]
                              : null,
                      onChanged: (int? value) {
                        _submitAnswer(index);
                      },
                    ),
                  ),
                );
              }),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  _submitAnswer(-1);
                },
                child: Text(
                  _currentQuestionIndex < _questions.length - 1
                      ? 'Selanjutnya'
                      : 'Selesai',
                  style: TextStyle(fontSize: 18.0),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
  });
}
