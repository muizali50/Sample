import 'package:flutter/material.dart';

class SleepMeditation extends StatefulWidget {
  const SleepMeditation({super.key});

  @override
  State<SleepMeditation> createState() => _SleepMeditationState();
}

class _SleepMeditationState extends State<SleepMeditation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: Text('sleep'),),
    );
  }
}