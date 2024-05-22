import 'package:flutter/material.dart';
import 'package:mind_labify/features/authentication/views/sub_features/onboarding/views/get_started_screen.dart';
import 'package:mind_labify/features/authentication/views/sub_features/onboarding/widgets/page_one.dart';
import 'package:mind_labify/features/authentication/views/sub_features/onboarding/widgets/page_two.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 209,
        ),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(
              () {
                isLastPage = index == 1;
              },
            );
          },
          children: const [
            PageOne(),
            PageTwo(),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 25,
        ),
        height: 209,
        child: Column(
          children: [
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 2,
                effect: WormEffect(
                  spacing: 5,
                  dotColor: const Color(
                    0xFF999999,
                  ),
                  activeDotColor: Theme.of(context).colorScheme.secondary,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
                onDotClicked: (index) {
                  controller.animateToPage(
                    index,
                    duration: const Duration(
                      microseconds: 500,
                    ),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
            Gaps.hGap30,
            isLastPage
                ? AppPrimaryButton(
                    text: 'Next',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GetStartedScreen(),
                        ),
                      );
                    },
                  )
                : AppPrimaryButton(
                    text: 'Next',
                    onTap: () {
                      controller.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
            Gaps.hGap15,
            isLastPage 
            ?
            const SizedBox()
            :
            TextButton(
              onPressed: () {
                controller.jumpToPage(
                  2,
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.11,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
