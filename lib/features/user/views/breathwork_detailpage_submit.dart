import 'package:flutter/material.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class BreathworkDetailpageSubmit extends StatefulWidget {
  const BreathworkDetailpageSubmit({super.key});

  @override
  State<BreathworkDetailpageSubmit> createState() =>
      _BreathworkDetailpageSubmitState();
}

class _BreathworkDetailpageSubmitState
    extends State<BreathworkDetailpageSubmit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  color: const Color(
                    0xFFffffff,
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "You've just finished:",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(
                            0xFF000000,
                          ),
                        ),
                      ),
                      Image(
                        height: 251,
                        width: 302,
                        image: AssetImage(
                          'assets/images/breath2.png',
                        ),
                      ),
                      Text(
                        'Deep Breath Dynamics',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(
                            0xFF000000,
                          ),
                        ),
                      ),
                      Gaps.hGap10,
                      Text(
                        '2-5 Mins',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(
                            0xFF000000,
                          ),
                        ),
                      ),
                      Gaps.hGap40,
                      Text(
                        'How do you feel?',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(
                            0xFF000000,
                          ),
                        ),
                      ),
                      Gaps.hGap15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            height: 50,
                            color: Color(
                              0xFF357343,
                            ),
                            width: 50,
                            image: AssetImage(
                              'assets/icons/s_happy.png',
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image(
                            color: Color(
                              0xFF656565,
                            ),
                            height: 50,
                            width: 50,
                            image: AssetImage(
                              'assets/icons/s_normal.png',
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image(
                            color: Color(
                              0xFFD79152,
                            ),
                            height: 50,
                            width: 50,
                            image: AssetImage(
                              'assets/icons/s_sad.png',
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image(
                            color: Color(
                              0xFFFF0303,
                            ),
                            height: 50,
                            width: 50,
                            image: AssetImage(
                              'assets/icons/s_tired.png',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gaps.hGap30,
                const SizedBox(
                  height: 144,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 34.0,
                  ),
                  child: AppPrimaryButton(
                    text: 'Submit',
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
