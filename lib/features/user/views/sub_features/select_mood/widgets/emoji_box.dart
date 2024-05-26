import 'package:flutter/material.dart';

class EmojiBox extends StatefulWidget {
  const EmojiBox({
    super.key,
    required this.onTap,
    required this.iconImageAddress,
    required this.iconColorCode,
  });

  final VoidCallback? onTap;
  final String? iconImageAddress;
  final int? iconColorCode;

  @override
  State<EmojiBox> createState() => _EmojiBoxState();
}

class _EmojiBoxState extends State<EmojiBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(
            0xFFF4F2E8,
          ),
        ),
      ),
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: widget.onTap,
          icon: ImageIcon(
            size: 70,
            color: Color(
              widget.iconColorCode!.toInt(),
            ),
            AssetImage(
              widget.iconImageAddress.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
