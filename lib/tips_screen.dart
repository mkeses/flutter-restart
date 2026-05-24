import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoCard(String title, List<String> points) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            ...points.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('• $point'),
              ),
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
        title: const Text('Information & Tips'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Mental health information for ages 10–18',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This page gives simple, useful tips for stress, emotions, school, friendships, and getting support.',
            style: TextStyle(fontSize: 16),
          ),

          _sectionTitle('Mental health basics'),
          _infoCard(
            'What mental health means',
            [
              'Mental health is about your thoughts, feelings, stress level, and how you handle daily life.',
              'Having hard days does not mean something is wrong with you.',
              'Everyone has emotions, and learning how to understand them is a skill.',
              'It is okay to ask for help even if you cannot explain exactly what is wrong.',
            ],
          ),
          _infoCard(
            'Signs you may need support',
            [
              'Feeling sad, worried, angry, empty, or overwhelmed for a long time.',
              'Losing interest in things you normally enjoy.',
              'Sleeping way more or way less than usual.',
              'Big changes in appetite, energy, motivation, or focus.',
              'Pulling away from friends, family, or school activities.',
              'Feeling like you cannot manage things on your own anymore.',
            ],
          ),

          _sectionTitle('Daily habits that help'),
          _infoCard(
            'Sleep',
            [
              'Try to keep a regular sleep schedule, even on weekends.',
              'Reduce phone or tablet use before bed because screens can make sleep harder.',
              'A calmer bedtime routine can help your body settle down.',
              'Poor sleep can make stress, sadness, and irritability feel worse.',
            ],
          ),
          _infoCard(
            'Movement and energy',
            [
              'Regular movement can improve mood and lower stress.',
              'You do not need intense workouts; walking, stretching, sports, dancing, or playing outside all count.',
              'Even short periods of movement can help when you feel stuck or overwhelmed.',
            ],
          ),
          _infoCard(
            'Food and water',
            [
              'Eating regular meals and drinking enough water can help with focus and energy.',
              'Too much caffeine can make anxiety or restlessness feel worse.',
              'Your brain works better when your body is cared for too.',
            ],
          ),

          _sectionTitle('Stress and school'),
          _infoCard(
            'When school feels overwhelming',
            [
              'Break big tasks into smaller steps.',
              'Start with the easiest part if the whole task feels too big.',
              'Use a planner, checklist, or notes app to organize what needs to happen next.',
              'Doing something is often better than waiting for perfect motivation.',
            ],
          ),
          _infoCard(
            'Before tests or presentations',
            [
              'Practice ahead of time in small chunks instead of cramming everything at once.',
              'Try slow breathing before the stressful moment starts.',
              'Replace thoughts like “I am going to fail” with “This is hard, but I can do my best.”',
              'Getting support from a teacher, parent, or counselor is a smart move, not a weakness.',
            ],
          ),

          _sectionTitle('Emotions and coping'),
          _infoCard(
            'Healthy ways to calm down',
            [
              'Try deep breathing, muscle relaxation, or a short walk.',
              'Listen to music, draw, journal, stretch, or sit somewhere quiet.',
              'Spend time with a pet if that helps you feel calmer.',
              'Take a break from the stressful thing, then return when your body feels more settled.',
            ],
          ),
          _infoCard(
            'Negative self-talk',
            [
              'Notice when your brain says harsh things like “I am bad at everything.”',
              'Ask if that thought is fully true, or if stress is making it sound worse than it is.',
              'Try changing it to something more fair, like “This is difficult, but I am learning.”',
              'You do not have to fake positivity; just aim for more realistic and less cruel self-talk.',
            ],
          ),
          _infoCard(
            'Journaling',
            [
              'Writing things down can help you understand what you are feeling.',
              'A journal can help you spot patterns, triggers, and what helps you recover.',
              'You can write full paragraphs, bullet points, or even just a few words.',
              'If talking feels hard, writing is still a valid way to process your thoughts.',
            ],
          ),

          _sectionTitle('Friends, family, and support'),
          _infoCard(
            'Talking to someone',
            [
              'You do not need to wait until things are terrible to talk to someone.',
              'A trusted adult can be a parent, caregiver, teacher, school counselor, coach, older sibling, or relative.',
              'It is okay to say, “I do not fully understand what I am feeling, but I know I need support.”',
              'Being listened to without judgment can make a huge difference.',
            ],
          ),
          _infoCard(
            'Friendship and social pressure',
            [
              'Real friends should not make you feel unsafe, ashamed, or constantly stressed.',
              'It is okay to set boundaries, take space, or say no.',
              'You do not need to share everything online or respond to everything immediately.',
              'If social media makes you feel worse, taking breaks can help.',
            ],
          ),

          _sectionTitle('When to reach out for more help'),
          _infoCard(
            'Ask for professional help if',
            [
              'Your feelings are not going away or are getting stronger.',
              'Stress or sadness is affecting school, sleep, eating, or relationships.',
              'You feel hopeless, numb, or unable to cope.',
              'You are thinking about hurting yourself or you do not feel safe.',
            ],
          ),
          _infoCard(
            'Places to ask for help',
            [
              'A parent or caregiver.',
              'A school counselor, school social worker, or teacher.',
              'A doctor, pediatrician, therapist, or mental health professional.',
              'A local youth mental health organization or support line.',
            ],
          ),

          _sectionTitle('Emergency support'),
          _infoCard(
            'Get urgent help now if needed',
            [
              'If you or someone else may be in immediate danger, call 911 right away.',
              'In the U.S. and Canada, call or text 988 for immediate mental health crisis support.',
              'Kids Help Phone is available in Canada at 1-800-668-6868.',
              'If someone talks about suicide or self-harm, always take it seriously and tell a trusted adult immediately.',
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}