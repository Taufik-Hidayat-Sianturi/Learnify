import 'package:flutter/material.dart';
import 'EnglishModule1.dart';
import 'EnglishModule2.dart';

class BahasaInggrisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bahasa Inggris'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildModuleCard(context, 'Module 1: About Me', Colors.purple[100]!,
              EnglishModule1()),
          SizedBox(height: 16.0),
          buildModuleCard(context, 'Module 2: My School Activities',
              Colors.orange[100]!, EnglishModule2()),
        ],
      ),
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
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
