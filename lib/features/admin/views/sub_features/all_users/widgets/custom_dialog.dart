import 'package:flutter/material.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/search_field.dart';
import 'package:mind_labify/utils/gaps.dart';

class CustomDialogWidget extends StatefulWidget {
  const CustomDialogWidget({
    super.key,
    this.onPressedMale,
    this.onPressedFemale,
    this.controller,
    this.isAge = false,
  });

  final VoidCallback? onPressedMale;
  final VoidCallback? onPressedFemale;
  final TextEditingController? controller;
  final bool? isAge;

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  bool _showField = false;
  @override
  void initState() {
    _showField = widget.isAge!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ),
          color: const Color(
            0xFFffffff,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _showField
                ? const Text(
                    'Select Age',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(
                        0xFF131313,
                      ),
                    ),
                  )
                : const Text(
                    'Select Gender',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(
                        0xFF131313,
                      ),
                    ),
                  ),
            _showField
                ? const Text(
                    'Select age by typing only numbers',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(
                        0xFF131313,
                      ),
                    ),
                  )
                : const SizedBox(),
            Gaps.hGap15,
            _showField
                ? SizedBox(
                    width: 300,
                    child: SearchField(
                      controller: widget.controller,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: widget.onPressedMale,
                          child: const Text(
                            'Male',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(
                                0xFF131313,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onPressedFemale,
                          child: const Text(
                            'Female',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(
                                0xFF131313,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            _showField
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: const Text(
                        'Ok',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(
                            0xFF131313,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
