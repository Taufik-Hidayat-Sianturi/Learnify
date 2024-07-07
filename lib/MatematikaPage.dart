import 'package:flutter/material.dart';
import 'MathModule1.dart'; // Import halaman modul 1
import 'MathModule2.dart';

class MatematikaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matematika'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildModuleCard(context, 'Modul 1 : Bilangan Bulat',
                Colors.purple[100]!, MathModule1()),
            SizedBox(
                height: 16.0), // Menambahkan jarak antara modul 1 dan modul 2
            buildModuleCard(
                context,
                'Modul 2 : Bilangan Rasional',
                Colors.orange[100]!,
                MathModule2()), // Ganti dengan halaman modul 2 jika ada
          ],
        ),
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
