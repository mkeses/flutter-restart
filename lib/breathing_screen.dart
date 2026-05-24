import 'package:flutter/material.dart';
import 'breathing_exercise_player_screen.dart';

class BreathingScreen extends StatelessWidget {
  const BreathingScreen({super.key});

  void _showInfo(
    BuildContext context, {
    required String title,
    required String benefits,
    required String howTo,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Benefits',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(benefits),
                const SizedBox(height: 16),
                const Text(
                  'How to do it',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(howTo),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _openExercise(BuildContext context, String title) {
    if (title == 'Box Breathing') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BreathingExercisePlayerScreen(
            title: 'Box Breathing',
            color: Colors.teal,
            steps: const [
              BreathStepConfig(
                type: BreathStepType.inhale,
                seconds: 4,
                instruction: 'Breathe in slowly through your nose.',
              ),
              BreathStepConfig(
                type: BreathStepType.hold,
                seconds: 4,
                instruction: 'Hold your breath gently.',
              ),
              BreathStepConfig(
                type: BreathStepType.exhale,
                seconds: 4,
                instruction: 'Breathe out slowly and smoothly.',
              ),
              BreathStepConfig(
                type: BreathStepType.hold,
                seconds: 4,
                instruction: 'Pause before the next breath.',
              ),
            ],
          ),
        ),
      );
    } else if (title == '4-7-8 Breathing') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BreathingExercisePlayerScreen(
            title: '4-7-8 Breathing',
            color: Colors.deepPurple,
            steps: const [
              BreathStepConfig(
                type: BreathStepType.inhale,
                seconds: 4,
                instruction: 'Inhale gently through your nose.',
              ),
              BreathStepConfig(
                type: BreathStepType.hold,
                seconds: 7,
                instruction: 'Hold your breath and stay relaxed.',
              ),
              BreathStepConfig(
                type: BreathStepType.exhale,
                seconds: 8,
                instruction: 'Exhale slowly through your mouth.',
              ),
            ],
          ),
        ),
      );
    } else if (title == 'Pursed-Lip Breathing') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BreathingExercisePlayerScreen(
            title: 'Pursed-Lip Breathing',
            color: Colors.orange,
            steps: const [
              BreathStepConfig(
                type: BreathStepType.inhale,
                seconds: 2,
                instruction: 'Breathe in through your nose.',
              ),
              BreathStepConfig(
                type: BreathStepType.exhale,
                seconds: 4,
                instruction: 'Exhale slowly through pursed lips.',
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildExerciseCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String benefits,
    required String howTo,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Colors.teal),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => _openExercise(context, title),
                    child: const Text('Start Exercise'),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                _showInfo(
                  context,
                  title: title,
                  benefits: benefits,
                  howTo: howTo,
                );
              },
              icon: const Icon(Icons.info_outline),
              tooltip: 'Exercise info',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Exercises'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Choose a breathing exercise',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'These exercises can help with calm, focus, and emotional regulation.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          _buildExerciseCard(
            context,
            icon: Icons.crop_square,
            title: 'Box Breathing',
            subtitle: 'A steady 4-4-4-4 pattern for stress and focus.',
            benefits:
                'Box breathing can help lower stress, calm the mind, and support nervous system regulation. It is often used to slow breathing and create a sense of control.',
            howTo:
                'Inhale for 4 counts, hold for 4, exhale for 4, then hold for 4. Repeat for several rounds.',
          ),
          _buildExerciseCard(
            context,
            icon: Icons.nightlight_round,
            title: '4-7-8 Breathing',
            subtitle: 'A slower pattern often used for calming and sleep.',
            benefits:
                '4-7-8 breathing may help reduce stress, quiet the mind, and support relaxation or sleep.',
            howTo:
                'Inhale for 4 counts, hold for 7, and exhale for 8. Start with a few cycles.',
          ),
          _buildExerciseCard(
            context,
            icon: Icons.air,
            title: 'Pursed-Lip Breathing',
            subtitle: 'A simple exercise to slow breathing and ease tension.',
            benefits:
                'Pursed-lip breathing helps slow the exhale and improve breathing control, which can feel grounding.',
            howTo:
                'Inhale through your nose for about 2 counts, then exhale through pursed lips for about 4 counts.',
          ),
        ],
      ),
    );
  }
}