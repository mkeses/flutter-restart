import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class BreathingExercisePlayerScreen extends StatefulWidget {
  final String title;
  final List<BreathStepConfig> steps;
  final Color color;

  const BreathingExercisePlayerScreen({
    super.key,
    required this.title,
    required this.steps,
    required this.color,
  });

  @override
  State<BreathingExercisePlayerScreen> createState() =>
      _BreathingExercisePlayerScreenState();
}

class _BreathingExercisePlayerScreenState
    extends State<BreathingExercisePlayerScreen> with TickerProviderStateMixin {
  Timer? _timer;
  int _currentStepIndex = 0;
  int _secondsLeft = 0;
  int _stepDuration = 0;
  bool _isRunning = false;

  late AnimationController _characterController;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();

    _characterController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.85,
      upperBound: 1.15,
      value: 1.0,
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _setStep(0, autoAnimate: false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _characterController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  BreathStepConfig get currentStep => widget.steps[_currentStepIndex];

  void _setStep(int index, {bool autoAnimate = true}) {
    _currentStepIndex = index;
    _stepDuration = widget.steps[index].seconds;
    _secondsLeft = _stepDuration;

    if (autoAnimate) {
      _animateForCurrentStep();
    }
  }

  void _animateForCurrentStep() {
    final step = currentStep;

    if (step.type == BreathStepType.inhale) {
      _characterController.animateTo(
        1.15,
        duration: Duration(seconds: step.seconds),
        curve: Curves.easeInOut,
      );
    } else if (step.type == BreathStepType.exhale) {
      _characterController.animateTo(
        0.85,
        duration: Duration(seconds: step.seconds),
        curve: Curves.easeInOut,
      );
    } else {
      _characterController.animateTo(
        1.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _startExercise() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _animateForCurrentStep();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        _secondsLeft--;

        if (_secondsLeft <= 0) {
          final nextIndex = (_currentStepIndex + 1) % widget.steps.length;
          _setStep(nextIndex);
        }
      });
    });
  }

  void _pauseExercise() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetExercise() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _setStep(0, autoAnimate: false);
      _characterController.value = 1.0;
    });
  }

  String _stepLabel(BreathStepType type) {
    switch (type) {
      case BreathStepType.inhale:
        return 'Inhale';
      case BreathStepType.hold:
        return 'Hold';
      case BreathStepType.exhale:
        return 'Exhale';
    }
  }

  double _progressValue() {
    if (_stepDuration == 0) return 0;
    return (_stepDuration - _secondsLeft) / _stepDuration;
  }

  @override
  Widget build(BuildContext context) {
    final step = currentStep;
    final progress = _progressValue();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 14,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation(widget.color),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              _stepLabel(step.type),
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$_secondsLeft',
              style: const TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    _characterController,
                    _floatController,
                  ]),
                  builder: (context, child) {
                    final floatY =
                        math.sin(_floatController.value * math.pi) * 10;

                    return Transform.translate(
                      offset: Offset(0, -floatY),
                      child: Transform.scale(
                        scale: _characterController.value,
                        child: _BreathingBuddy(
                          phase: step.type,
                          color: widget.color,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              step.instruction,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isRunning ? null : _startExercise,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Start'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isRunning ? _pauseExercise : null,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Pause'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: _resetExercise,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

enum BreathStepType { inhale, hold, exhale }

class BreathStepConfig {
  final BreathStepType type;
  final int seconds;
  final String instruction;

  const BreathStepConfig({
    required this.type,
    required this.seconds,
    required this.instruction,
  });
}

class _BreathingBuddy extends StatelessWidget {
  final BreathStepType phase;
  final Color color;

  const _BreathingBuddy({
    required this.phase,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isHold = phase == BreathStepType.hold;
    final isExhale = phase == BreathStepType.exhale;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 4),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.18),
                blurRadius: 20,
                spreadRadius: 8,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 48,
                left: 48,
                child: _Eye(isClosed: isHold),
              ),
              Positioned(
                top: 48,
                right: 48,
                child: _Eye(isClosed: isHold),
              ),
              Positioned(
                bottom: 42,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: isExhale ? 26 : 42,
                  height: isHold ? 6 : 20,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                        color: color,
                        width: 4,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                child: Icon(
                  Icons.self_improvement,
                  color: color.withOpacity(0.75),
                  size: 28,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: phase == BreathStepType.inhale ? 110 : 90,
          height: 14,
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}

class _Eye extends StatelessWidget {
  final bool isClosed;

  const _Eye({required this.isClosed});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 18,
      height: isClosed ? 3 : 18,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}