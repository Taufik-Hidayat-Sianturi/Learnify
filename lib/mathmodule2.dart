import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'quiz_page.dart';

class MathModule2 extends StatefulWidget {
  @override
  _MathModule2State createState() => _MathModule2State();
}

class _MathModule2State extends State<MathModule2> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'NE2LrOhYgXs', // Replace with the actual video ID
      params: YoutubePlayerParams(
        playlist: ['NE2LrOhYgXs'], // Add more video IDs here if needed
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
        title: Text('Modul 2: Bilangan Rasional'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modul 2: Bilangan Rasional',
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
                      builder: (context) => QuizPage(
                          quizId:
                              'Modul 2 : Bilangan Rasional'), // Use the correct quizId
                    ),
                  );
                },
                child: Text('Start Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
