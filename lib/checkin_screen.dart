import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  final Map<String, double> emotions = {
    'Happy': 3,
    'Sad': 3,
    'Fear': 3,
    'Surprise': 3,
    'Disgust': 3,
    'Anger': 3,
  };

  final Map<String, String> emojis = {
    'Happy': '😊',
    'Sad': '😢',
    'Fear': '😨',
    'Surprise': '😲',
    'Disgust': '🤢',
    'Anger': '😠',
  };

  void _submitCheckin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(checkinResults: emotions),
      ),
    );
  }

  void _goBackToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  Widget _buildEmotionCard(String emotion) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emojis[emotion]!,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              emotion,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('${emotions[emotion]!.round()} / 5'),
            Slider(
              value: emotions[emotion]!,
              min: 1,
              max: 5,
              divisions: 4,
              label: emotions[emotion]!.round().toString(),
              onChanged: (value) {
                setState(() {
                  emotions[emotion] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emotionList = emotions.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Check-In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'How are you feeling right now?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Rate each emotion from 1 to 5.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: emotionList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return _buildEmotionCard(emotionList[index]);
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitCheckin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Submit Check-In'),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _goBackToLogin,
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}