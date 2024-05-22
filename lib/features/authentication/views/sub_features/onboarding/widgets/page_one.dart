import 'package:flutter/material.dart';
import 'package:mind_labify/utils/gaps.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const Stack(
            children: [
              Image(
                image: AssetImage(
                  'assets/images/bg.png',
                ),
              ),
              Positioned(
                top: 45,
                left: 0,
                right: 0,
                child: Center(
                  child: Image(
                    height: 110,
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gaps.hGap20,
          const Image(
            height: 278,
            image: AssetImage(
              'assets/images/face.png',
            ),
          ),
          Gaps.hGap20,
          const Image(
            height: 53,
            image: AssetImage(
              'assets/images/name.png',
            ),
          ),
          Gaps.hGap05,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 45.0,
            ),
            child: Text(
              textAlign: TextAlign.center,
              'Here to help you cultivate a happy brain',
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
