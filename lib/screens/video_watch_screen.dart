import 'package:flutter/material.dart';

class VideoWatchScreen extends StatelessWidget {
  const VideoWatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch Videos')),
      body: const Center(
        child: Text(
          'Video Watch Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
