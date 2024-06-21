import 'package:flutter/material.dart';

class InnerPeaceMeditation extends StatefulWidget {
  const InnerPeaceMeditation({super.key});

  @override
  State<InnerPeaceMeditation> createState() => _InnerPeaceMeditationState();
}

class _InnerPeaceMeditationState extends State<InnerPeaceMeditation> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisSize: MainAxisSize.max,
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, int i) {
              return Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: Container(
                  color: const Color(
                    0xFFF2F5DB,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'All you do is breathe',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(
                                  0xFF000000,
                                ),
                              ),
                            ),
                            Text(
                              '20 Mins',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        height: 90,
                        width: 93,
                        child: Image(
                          image: AssetImage(
                            'assets/images/deepbreath.png',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
