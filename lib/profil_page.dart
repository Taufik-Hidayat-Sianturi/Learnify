import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'category_course_page.dart';
import 'main.dart'; // Import halaman main untuk navigasi setelah logout

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError ||
                          !snapshot.hasData ||
                          !snapshot.data!.exists) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                'Halo, Pengguna! Berikut adalah pencapain mu saat ini',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final userName = userData['fullName'] ?? 'Pengguna';
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              'Halo, $userName! Mari lanjutkan pembelajaran.',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                IconButton(
                  icon:
                      Icon(Icons.logout, size: 30), // Membuat ikon lebih besar
                  onPressed: () => _logout(context),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: FutureBuilder<List<QuizResult>>(
                future: _fetchQuizResults(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No quiz results found.'));
                  }

                  final quizResults = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: quizResults.length,
                    itemBuilder: (context, index) {
                      final quizResult = quizResults[index];
                      return buildProfileCard(context, quizResult);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Future<List<QuizResult>> _fetchQuizResults() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('quiz_results')
        .orderBy('timestamp', descending: true)
        .get();

    Map<String, QuizResult> highestScores = {};
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String quizId = data['quizId'] ?? '';
      int score = data['score'] ?? 0;
      int totalQuestions = data['totalQuestions'] ?? 0;
      DateTime timestamp = (data['timestamp'] as Timestamp).toDate();

      if (highestScores.containsKey(quizId)) {
        if (score > highestScores[quizId]!.score) {
          highestScores[quizId] = QuizResult(
            quizId: quizId,
            score: score,
            totalQuestions: totalQuestions,
            timestamp: timestamp,
          );
        }
      } else {
        highestScores[quizId] = QuizResult(
          quizId: quizId,
          score: score,
          totalQuestions: totalQuestions,
          timestamp: timestamp,
        );
      }
    }

    return highestScores.values.toList();
  }

  Widget buildProfileCard(BuildContext context, QuizResult quizResult) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical:
              8.0), // Menambahkan margin untuk memberikan jarak antar kartu
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Text(
              quizResult.quizId[0], // Use first letter of quizId
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quizResult.quizId,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              quizResult.score == quizResult.totalQuestions
                  ? Icon(Icons.check_circle, color: Colors.green, size: 24)
                  : Text(
                      'Score: ${quizResult.score}/${quizResult.totalQuestions}',
                      style: const TextStyle(fontSize: 16),
                    ),
              Text(
                'Date: ${quizResult.timestamp}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuizResult {
  final String quizId;
  final int score;
  final int totalQuestions;
  final DateTime timestamp;

  QuizResult({
    required this.quizId,
    required this.score,
    required this.totalQuestions,
    required this.timestamp,
  });
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: 1,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryCoursePage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
            break;
        }
      },
    );
  }
}
