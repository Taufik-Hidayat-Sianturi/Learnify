import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'quiz_page.dart';

class TeksDeskripsiPage extends StatefulWidget {
  @override
  _TeksDeskripsiPageState createState() => _TeksDeskripsiPageState();
}

class _TeksDeskripsiPageState extends State<TeksDeskripsiPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'r4-UGOBUD0A', // Extracted from URL
      params: YoutubePlayerParams(
        playlist: [
          'r4-UGOBUD0A',
          '0E89Tkpapwc' // Add more video IDs if needed
        ],
        startAt: Duration(seconds: 0),
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teks Deskripsi'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Teks Deskripsi',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            YoutubePlayerIFrame(
              controller: _controller,
              aspectRatio: 16 / 9,
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuizPage(quizId: 'Modul 1 : Teks Deskripsi'),
                    ),
                  );
                },
                child: Text('Mulai Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
