import 'package:flutter/material.dart';
import 'checkin_screen.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, double> checkinResults;

  const HomeScreen({
    super.key,
    required this.checkinResults,
  });

  @override
  Widget build(BuildContext context) {
    final topEmotion = checkinResults.entries.reduce(
      (a, b) => a.value >= b.value ? a : b,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Restart',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your strongest emotion right now looks like ${topEmotion.key.toLowerCase()} (${topEmotion.value.round()}/5).',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Home screen placeholder',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Later, this page can show breathing exercises, journaling prompts, mini games, and recommendations.',
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckinScreen(),
                  ),
                );
              },
              child: const Text('Back to Check-In'),
            ),
          ],
        ),
      ),
    );
  }
}