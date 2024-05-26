import 'package:flutter/material.dart';
import 'package:mind_labify/utils/gaps.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                const Image(
                  image: AssetImage(
                    'assets/images/bg1.png',
                  ),
                  height: 400,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        const SafeArea(
                          child: Image(
                            height: 61,
                            image: AssetImage(
                              'assets/images/logo.png',
                            ),
                          ),
                        ),
                        Gaps.hGap30,
                        Image(
                          height: MediaQuery.sizeOf(context).height * 0.4,
                          image: const AssetImage(
                            'assets/images/brain.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Image(
            height: 53,
            image: AssetImage(
              'assets/images/name.png',
            ),
          ),
          Gaps.hGap05,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
            ),
            child: Text(
              textAlign: TextAlign.center,
              'Dive & Explore Your Path to Wellness with us',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
