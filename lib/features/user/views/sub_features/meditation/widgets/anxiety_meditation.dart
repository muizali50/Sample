import 'package:flutter/material.dart';

class AnxietyMeditation extends StatefulWidget {
  const AnxietyMeditation({super.key});

  @override
  State<AnxietyMeditation> createState() => _AnxietyMeditationState();
}

class _AnxietyMeditationState extends State<AnxietyMeditation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('anx'),
      ),
    );
  }
}
