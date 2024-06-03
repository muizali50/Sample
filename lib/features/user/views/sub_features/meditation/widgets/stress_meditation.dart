import 'package:flutter/material.dart';

class StressMeditation extends StatefulWidget {
  const StressMeditation({super.key});

  @override
  State<StressMeditation> createState() => _StressMeditationState();
}

class _StressMeditationState extends State<StressMeditation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('stress'),
      ),
    );
  }
}
