import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_labify/features/user/views/select_stressors.dart';
import 'package:mind_labify/features/user/views/sub_features/select_mood/widgets/emoji_box.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class SelectMoodScreen extends StatefulWidget {
  const SelectMoodScreen({super.key});

  @override
  State<SelectMoodScreen> createState() => _SelectMoodScreenState();
}

class _SelectMoodScreenState extends State<SelectMoodScreen> {
  String selectedMood = '';
  void updateMood(
    String mood,
  ) {
    setState(
      () {
        selectedMood = mood;
      },
    );
  }

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
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'How do you feel today?',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(
                      0xFF371B34,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmojiBox(
                          onTap: () {
                            updateMood(
                              'happy',
                            );
                          },
                          iconImageAddress: selectedMood == 'happy'
                              ? 'assets/icons/s_happy.png'
                              : 'assets/icons/happy.png',
                          iconColorCode:
                              selectedMood == 'happy' ? 0xFFB9BF88 : 0xFFF4F2E8,
                        ),
                        EmojiBox(
                          onTap: () {
                            updateMood(
                              'normal',
                            );
                          },
                          iconImageAddress: selectedMood == 'normal'
                              ? 'assets/icons/s_normal.png'
                              : 'assets/icons/normal.png',
                          iconColorCode: selectedMood == 'normal'
                              ? 0xFFB9BF88
                              : 0xFFF4F2E8,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmojiBox(
                          onTap: () {
                            updateMood(
                              'confused',
                            );
                          },
                          iconImageAddress: selectedMood == 'confused'
                              ? 'assets/icons/s_tired.png'
                              : 'assets/icons/tired.png',
                          iconColorCode:
                              selectedMood == 'confused' ? 0xFFB9BF88 : 0xFFF4F2E8,
                        ),
                        EmojiBox(
                          onTap: () {
                            updateMood('sad');
                          },
                          iconImageAddress: selectedMood == 'sad'
                              ? 'assets/icons/s_sad.png'
                              : 'assets/icons/sad.png',
                          iconColorCode:
                              selectedMood == 'sad' ? 0xFFB9BF88 : 0xFFF4F2E8,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                  ),
                  child: AppPrimaryButton(
                    buttonColor: 0xFFF4F2E8,
                    text: 'I don’t feel good!',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectStressors(),
                        ),
                      );
                    },
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
