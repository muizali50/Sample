import 'package:flutter/material.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuotesBox extends StatefulWidget {
  const QuotesBox({
    super.key,
  });

  @override
  State<QuotesBox> createState() => _QuotesBoxState();
}

class _QuotesBoxState extends State<QuotesBox> {
  var controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(
      () {
        setState(
          () {
            currentPage = controller.page!.toInt();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 79,
          child: PageView.builder(
            onPageChanged: (int page) {
              setState(
                () {
                  currentPage = page;
                },
              );
            },
            controller: controller,
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  color: Theme.of(context).colorScheme.secondary.withOpacity(
                        0.5,
                      ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 258,
                      child:  Text(
                        '“It is better to conquer yourself than to win a thousand battles”',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(
                            0xFF707070,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Image(
                      height: 20,
                      color: Theme.of(context).colorScheme.secondary,
                      image: const AssetImage(
                        'assets/icons/quote.png',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Gaps.hGap15,
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: const ExpandingDotsEffect(
            radius: 0,
            dotHeight: 8,
            dotWidth: 10,
            spacing: 10,
            dotColor: Color(
              0xFF979797,
            ),
            activeDotColor: Color(
              0xFF87B39B,
            ),
          ),
        ),
      ],
    );
  }
}
