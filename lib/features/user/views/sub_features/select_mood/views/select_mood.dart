import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/user/user_bloc/user_bloc.dart';
import 'package:mind_labify/features/user/views/select_stressors.dart';
import 'package:mind_labify/features/user/views/sub_features/select_mood/widgets/emoji_box.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final userBloc = context.read<UserBloc>();
    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F2E8,
      ),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: const Color(
                        0xFFF4F2E8,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(
                        0xFFC9D0C5,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Column(
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
                      Gaps.hGap15,
                      Container(
                        padding: const EdgeInsets.all(
                          70,
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(
                            0xFFB9BF88,
                          ),
                        ),
                        child: Column(
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
                                      ? 'assets/icons/s_happy_reaction.png'
                                      : 'assets/icons/happy_reaction.png',
                                  iconColorCode: selectedMood == 'happy'
                                      ? 0xFFD5DFD2
                                      : 0xFFF4F2E8,
                                ),
                                EmojiBox(
                                  onTap: () {
                                    updateMood(
                                      'sad',
                                    );
                                  },
                                  iconImageAddress: selectedMood == 'sad'
                                      ? 'assets/icons/s_sad_reaction.png'
                                      : 'assets/icons/sad_reaction.png',
                                  iconColorCode: selectedMood == 'sad'
                                      ? 0xFFD5DFD2
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
                                      'surprise',
                                    );
                                  },
                                  iconImageAddress: selectedMood == 'surprise'
                                      ? 'assets/icons/s_surprise_reaction.png'
                                      : 'assets/icons/surprise_reaction.png',
                                  iconColorCode: selectedMood == 'surprise'
                                      ? 0xFFD5DFD2
                                      : 0xFFF4F2E8,
                                ),
                                EmojiBox(
                                  onTap: () {
                                    updateMood(
                                      'fear',
                                    );
                                  },
                                  iconImageAddress: selectedMood == 'fear'
                                      ? 'assets/icons/s_fear_reaction.png'
                                      : 'assets/icons/fear_reaction.png',
                                  iconColorCode: selectedMood == 'fear'
                                      ? 0xFFD5DFD2
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
                                      'anger',
                                    );
                                  },
                                  iconImageAddress: selectedMood == 'anger'
                                      ? 'assets/icons/s_anger_reaction.png'
                                      : 'assets/icons/anger_reaction.png',
                                  iconColorCode: selectedMood == 'anger'
                                      ? 0xFFD5DFD2
                                      : 0xFFF4F2E8,
                                ),
                                EmojiBox(
                                  onTap: () {
                                    updateMood(
                                      'disgust',
                                    );
                                  },
                                  iconImageAddress: selectedMood == 'disgust'
                                      ? 'assets/icons/s_disgust_reaction.png'
                                      : 'assets/icons/disgust_reaction.png',
                                  iconColorCode: selectedMood == 'disgust'
                                      ? 0xFFD5DFD2
                                      : 0xFFF4F2E8,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gaps.hGap35,
                      BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is MoodSelected) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (
                                  context,
                                ) =>
                                    const SelectStressors(),
                              ),
                            );
                          } else if (state is MoodSelectedFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.message,
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is MoodSelecting) {
                            return const CircularProgressIndicator();
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            child: AppPrimaryButton(
                              buttonColor: 0xFFF4F2E8,
                              text: 'I am feeling $selectedMood!',
                              onTap: () {
                                if (selectedMood.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please select the mood',
                                      ),
                                    ),
                                  );
                                } else {
                                  _saveMood(
                                    context,
                                    selectedMood,
                                  );
                                  userBloc.add(
                                    SelectMood(
                                      mood: selectedMood,
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveMood(
    BuildContext context,
    String mood,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'mood',
      mood,
    );
  }
}
