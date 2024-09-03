import 'package:flutter/material.dart';
import 'package:mind_labify/utils/gaps.dart';

class WeeklyProgressIndicator extends StatefulWidget {
  const WeeklyProgressIndicator({
    super.key,
    required this.title,
    required this.indicatorValue,
    required this.progressPercentage,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
  });

  final String title;
  final double indicatorValue;
  final String progressPercentage;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  State<WeeklyProgressIndicator> createState() =>
      _WeeklyProgressIndicatorState();
}

class _WeeklyProgressIndicatorState extends State<WeeklyProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: const Color(
              0xFF000000,
            ),
          ),
        ),
        Gaps.hGap10,
        LinearProgressIndicator(
          value: widget.indicatorValue,
          backgroundColor: const Color(
            0xFFCDC7DE,
          ).withOpacity(
            0.35,
          ),
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(
            3,
          ),
          minHeight: 3,
        ),
        Gaps.hGap05,
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${widget.progressPercentage.toString()} % Achieved',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(
                0xFF000000,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
