import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'quiz_page.dart';

class EnglishModule2 extends StatefulWidget {
  @override
  _EnglishModule2State createState() => _EnglishModule2State();
}

class _EnglishModule2State extends State<EnglishModule2> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '4b2PNQOZfcA', // Video ID from the provided link
      params: YoutubePlayerParams(
        playlist: ['4b2PNQOZfcA'], // Add more video IDs here if needed
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
        title: Text('Module 2: My School Activities'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Module 2: My School Activities',
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
                              'Module 2 : My School Activities'), // Use the correct quizId
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
