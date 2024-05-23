import 'package:flutter/material.dart';

class FilterField extends StatefulWidget {
  const FilterField({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String? title;
  final VoidCallback? onPressed;

  @override
  State<FilterField> createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15,
        ),
        color: const Color(
          0xFFF1F1F1,
        ),
      ),
      child: Center(
        child: Row(
          children: [
            Text(
              widget.title.toString(),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(
                  0xFF000000,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            IconButton(
              onPressed: widget.onPressed,
              icon: const Icon(
                Icons.arrow_drop_down_rounded,
                color: Color(
                  0xFF000000,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
