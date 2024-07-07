import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'quiz_page.dart';

class TeksNarasiPage extends StatefulWidget {
  @override
  _TeksNarasiPageState createState() => _TeksNarasiPageState();
}

class _TeksNarasiPageState extends State<TeksNarasiPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '0E89Tkpapwc', // Video ID from the provided link
      params: YoutubePlayerParams(
        playlist: ['0E89Tkpapwc'], // Add more video IDs here if needed
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
        title: Text('Teks Narasi'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Teks Narasi',
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
                          QuizPage(quizId: 'Modul 2 : Teks Narasi'),
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
