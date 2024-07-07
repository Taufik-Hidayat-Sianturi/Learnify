import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'BahasaInggrisPage.dart';
import 'BahasaIndonesiaPage.dart';
import 'MatematikaPage.dart';
import 'profil_page.dart';

class CategoryCoursePage extends StatelessWidget {
  const CategoryCoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserProfile(),
          Expanded(
            child: CourseHistory(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
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
      currentIndex: 0,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CategoryCoursePage()),
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

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blue,
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                  radius: 24.0,
                ),
                SizedBox(width: 16.0),
                Text(
                  'Guest',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          );
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final userName = userData['fullName'] ?? 'Pengguna';
        return Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.blue,
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
                radius: 24.0,
              ),
              SizedBox(width: 16.0),
              Text(
                userName,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildPopularCourseCard(
    BuildContext context, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Icon(
      icon,
      color: Colors.white,
      size: 36.0,
    ),
  );
}

class CourseHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        buildModuleCard(
            context, 'Matematika', Colors.blue[100]!, MatematikaPage()),
        buildModuleCard(context, 'Bahasa Indonesia', Colors.orange[100]!,
            BahasaIndonesiaPage()),
        buildModuleCard(context, 'Bahasa Inggris', Colors.purple[100]!,
            BahasaInggrisPage()),
      ],
    );
  }

  Widget buildModuleCard(
      BuildContext context, String title, Color color, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Icon(
              Icons.book,
              size: 40,
            ),
            SizedBox(width: 16.0),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
