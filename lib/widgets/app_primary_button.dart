import 'package:flutter/material.dart';

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(
        50,
      ),
      onHover: (value) {
        setState(
          () {
            _isHovering = value;
          },
        );
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            50,
          ),
          color: _isHovering
              ? const Color(
                  0xFFD5DFD2,
                ).withOpacity(
                  0.8,
                )
              : const Color(
                  0xFFD5DFD2,
                ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(
                0xFF000000,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
