import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class SelectStressors extends StatefulWidget {
  const SelectStressors({super.key});

  @override
  State<SelectStressors> createState() => _SelectStressorsState();
}

class _SelectStressorsState extends State<SelectStressors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFD5DFD2,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(
            size: 22,
            CupertinoIcons.xmark,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'What stressors are affecting you today?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(
                      0xFF371B34,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: AppPrimaryButton(
                    buttonColor: 0xFFF4F2E8,
                    text: 'Continue',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
