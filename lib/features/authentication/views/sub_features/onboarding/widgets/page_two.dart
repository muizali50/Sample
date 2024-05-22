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
          const Expanded(
            child: Stack(
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/bg1.png',
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        Image(
                          height: 61,
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                        ),
                        Gaps.hGap45,
                        Image(
                          height: 400,
                          image: AssetImage(
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
