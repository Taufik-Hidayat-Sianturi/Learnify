import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'quiz_page.dart';

class EnglishModule1 extends StatefulWidget {
  @override
  _EnglishModule1State createState() => _EnglishModule1State();
}

class _EnglishModule1State extends State<EnglishModule1> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'Fzuul_fVsBk',
      params: YoutubePlayerParams(
        playlist: ['Fzuul_fVsBk'],
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
        title: Text('Module 1: About Me'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Module 1: About Me',
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
                          QuizPage(quizId: 'Module 1 : About Me'),
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
