import 'package:flutter/material.dart';
import 'checkin_screen.dart';
import 'journal_screen.dart';
import 'breathing_screen.dart';
import 'tips_screen.dart';

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
        title: const Text('Restart Home'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome back',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Your strongest emotion right now looks like ${topEmotion.key.toLowerCase()} (${topEmotion.value.round()}/5).',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'What would you like to do?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JournalScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text('Open Journal'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BreathingScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text('Breathing Exercises'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text('Mini Games'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TipsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text('Information & Tips'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Recommended for you',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Later, this section can recommend journaling, breathing, games, or reading based on your recent check-ins.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
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