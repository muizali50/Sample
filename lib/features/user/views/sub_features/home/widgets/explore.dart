import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 62,
        width: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: const Color(
            0xFFC9D1C6,
          ),
        ),
        child: Center(
          child: Text(
            widget.title,
          ),
        ),
      ),
    );
  }
}
