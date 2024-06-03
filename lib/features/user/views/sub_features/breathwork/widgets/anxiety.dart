import 'package:flutter/material.dart';

class Anxiety extends StatefulWidget {
  const Anxiety({super.key});

  @override
  State<Anxiety> createState() => _AnxietyState();
}

class _AnxietyState extends State<Anxiety> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: Text('anx'),),
    );
  }
}