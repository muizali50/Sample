import 'package:flutter/material.dart';
import 'package:mind_labify/features/user/views/meditation_detailpage_submit.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class MeditationDetailpageStart extends StatefulWidget {
  const MeditationDetailpageStart({super.key});

  @override
  State<MeditationDetailpageStart> createState() =>
      _MeditationDetailpageStartState();
}

class _MeditationDetailpageStartState extends State<MeditationDetailpageStart> {
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
                    horizontal: 45,
                  ),
                  color: const Color(
                    0xFFffffff,
                  ),
                  child: const Image(
                    height: 251,
                    width: 302,
                    image: AssetImage(
                      'assets/images/breath2.png',
                    ),
                  ),
                ),
                Gaps.hGap30,
                Text(
                  'Intro to Meditation',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Gaps.hGap30,
                Text(
                  '2-5 Mins',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(
                  height: 144,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 34.0,
                  ),
                  child: AppPrimaryButton(
                    text: 'Start',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const MeditationDetailpageSubmit(),
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
