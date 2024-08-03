import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.isPassword = false,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.isBorder = false,
    this.isAutoFocue = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool isBorder;
  final bool isAutoFocue;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObsecure = false;
  @override
  void initState() {
    _isObsecure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.isAutoFocue ? true : false,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: _isObsecure,
      validator: widget.validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: widget.isBorder
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                )
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: widget.isBorder
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                )
              : BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 19,
        ),
        filled: true,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(
                    () {
                      _isObsecure = !_isObsecure;
                    },
                  );
                },
                icon: Icon(
                  _isObsecure
                      ? CupertinoIcons.eye_fill
                      : CupertinoIcons.eye_slash_fill,
                  color: const Color(
                    0xFFD9D8D8,
                  ),
                ),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        isDense: true,
        fillColor: const Color(
          0xFFEAEAEA,
        ),
      ),
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}
