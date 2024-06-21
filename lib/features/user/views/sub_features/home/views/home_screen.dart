import 'package:flutter/material.dart';
import 'package:mind_labify/features/user/views/sub_features/home/widgets/explore.dart';
import 'package:mind_labify/features/user/views/sub_features/home/widgets/quotes_box.dart';
import 'package:mind_labify/features/user/views/sub_features/home/widgets/weekly_progress_indicator.dart';
import 'package:mind_labify/utils/gaps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 52,
              ),
              height: 363,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/homebg.png',
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2.0,
                            color: const Color(
                              0xFFFFFFFF,
                            ),
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1714138664762-8ea7ae5c814e?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi Sanya!',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(
                                0xFFFFFFFF,
                              ),
                            ),
                          ),
                          Gaps.hGap05,
                          Text(
                            'You are feeling Sad today',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(
                                0xFFFFFFFF,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: ImageIcon(
                              color: Theme.of(context).colorScheme.onSurface,
                              const AssetImage(
                                'assets/icons/noti.png',
                              ),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 2,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: const Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gaps.hGap25,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 21,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFFFFFF,
                      ),
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Weekly Progress',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(
                              0xFF2B2B2B,
                            ),
                          ),
                        ),
                        Gaps.hGap15,
                        WeeklyProgressIndicator(
                          title: 'Meditation',
                          indicatorValue: 0.3,
                          progressPercentage: 75.toString(),
                        ),
                        WeeklyProgressIndicator(
                          title: 'Breathwork',
                          indicatorValue: 0.3,
                          progressPercentage: 75.toString(),
                        ),
                        WeeklyProgressIndicator(
                          title: 'Journals',
                          indicatorValue: 0.3,
                          progressPercentage: 75.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gaps.hGap30,
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Recommended for you',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(
                    0xFF2B2B2B,
                  ),
                ),
              ),
            ),
            Gaps.hGap20,
            SizedBox(
              height: 180,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, int i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          height: 132,
                          width: 113,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFF3EFB1,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: const Image(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1584448097639-99cf648e8def?q=80&w=1355&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            ),
                          ),
                        ),
                        const Text(
                          'Focus',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(
                              0xFF2B2B2B,
                            ),
                          ),
                        ),
                        const Text(
                          '4-12 min',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xFFB7B7B7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Gaps.hGap20,
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: QuotesBox(),
            ),
            Gaps.hGap20,
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Text(
                'Explore',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(
                    0xFF2B2B2B,
                  ),
                ),
              ),
            ),
            Gaps.hGap20,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Explore(
                    title: 'Journals',
                    onTap: () {},
                  ),
                  Explore(
                    title: 'Positive Declarations',
                    onTap: () {},
                  )
                ],
              ),
            ),
            Gaps.hGap20,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Explore(
                    title: 'Fun Facts',
                    onTap: () {},
                  ),
                  Explore(
                    title: 'Need Help?',
                    onTap: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  Text(
                    'Latest Blogs',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Theme.of(context).colorScheme.secondary,
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.hGap10,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(
                        0.2,
                      ),
                ),
                child: const Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sleep as meditation',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0Xff2B2B2B),
                          ),
                        ),
                        SizedBox(
                          width: 220,
                          child: Text(
                            'In this session we learn to see sleep as a natural ....',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0Xff2B2B2B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1437751059337-ea72d4f73fcf?q=80&w=1461&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
