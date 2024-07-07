import 'package:flutter/material.dart';
import 'TeksDeskripsiPage.dart';
import 'TeksNarasiPage.dart';

class BahasaIndonesiaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bahasa Indonesia'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildModuleCard(context, 'Teks Deskripsi', Colors.purple[100]!),
          SizedBox(height: 16.0),
          buildModuleCard(context, 'Teks Narasi', Colors.orange[100]!),
        ],
      ),
    );
  }

  Widget buildModuleCard(BuildContext context, String title, Color color) {
    return InkWell(
      onTap: () {
        if (title == 'Teks Deskripsi') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeksDeskripsiPage()),
          );
        } else if (title == 'Teks Narasi') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeksNarasiPage()),
          );
        }
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
