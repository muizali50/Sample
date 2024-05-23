import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.controller,
  });

  final TextEditingController? controller;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 9,
          horizontal: 9,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(
            0xFF000000,
          ),
        ),
        filled: true,
        hintText: 'Search',
        hintStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Color(
            0xFF371B34,
          ),
        ),
        isDense: true,
        fillColor: const Color(
          0xFFEAEAEA,
        ),
      ),
    );
  }
}
