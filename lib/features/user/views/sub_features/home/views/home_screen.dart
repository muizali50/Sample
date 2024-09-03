import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/authentication/bloc/authentication_bloc.dart';
import 'package:mind_labify/features/user/views/blog.dart';
import 'package:mind_labify/features/user/views/blog_detial_page.dart';
import 'package:mind_labify/features/user/views/faqs_screen.dart';
import 'package:mind_labify/features/user/views/journal.dart';
import 'package:mind_labify/features/user/views/meditation_detailpage_start.dart';
import 'package:mind_labify/features/user/views/positive_declarations_screen.dart';
import 'package:mind_labify/features/user/views/sub_features/home/widgets/explore.dart';
import 'package:mind_labify/features/user/views/sub_features/home/widgets/quotes_box.dart';
import 'package:mind_labify/features/user/views/sub_features/home/widgets/weekly_progress_indicator.dart';
import 'package:mind_labify/features/user/views/sub_features/progress_tracking/views/progress_tracking_screen.dart';
import 'package:mind_labify/user_provider.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AdminBloc adminBloc;
  late final UserProvider userProvider;
  late final AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      authenticationBloc.add(
        const GetUser(),
      );
    }
    authenticationBloc.add(
      const GetUser(),
    );
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.breathworkVideos.isEmpty) {
      adminBloc.add(
        GetBreathworkVideo(),
      );
    }
    if (adminBloc.meditationVideos.isEmpty) {
      adminBloc.add(
        GetMeditationVideo(),
      );
    }

    if (adminBloc.activeBlogs.isEmpty) {
      adminBloc.add(
        GetBlog(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.read<AdminBloc>();
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<UserProvider>(
                            builder: (context, userProvider, child) {
                              final userName = userProvider.user?.name ?? '';
                              return Text(
                                'Hi $userName!',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color(
                                    0xFFFFFFFF,
                                  ),
                                ),
                              );
                            },
                          ),
                          Gaps.hGap05,
                          Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                            return Text(
                              'You are feeling ${userProvider.user?.mood ?? ''} today',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(
                                  0xFFFFFFFF,
                                ),
                              ),
                            );
                          }),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const ProgressTrackingScreen(),
                        ),
                      );
                    },
                    child: Container(
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
                          Consumer<UserProvider>(
                            builder: (context, userProvider, child) {
                              return WeeklyProgressIndicator(
                                title: 'Meditation',
                                indicatorValue: (userProvider
                                                .user
                                                ?.meditationWatchedVideos
                                                ?.length ??
                                            0)
                                        .toDouble() /
                                    5.0,
                                progressPercentage:
                                    '${((userProvider.user?.meditationWatchedVideos?.length ?? 0).toDouble() / 5.0 * 100).toInt()}',
                              );
                            },
                          ),
                          Consumer<UserProvider>(
                            builder: (context, userProvider, child) {
                              return WeeklyProgressIndicator(
                                title: 'Breathwork',
                                indicatorValue: (userProvider
                                                .user
                                                ?.breathworkWatchedVideos
                                                ?.length ??
                                            0)
                                        .toDouble() /
                                    5.0,
                                progressPercentage:
                                    '${((userProvider.user?.breathworkWatchedVideos?.length ?? 0).toDouble() / 5.0 * 100).toInt()}',
                              );
                            },
                          ),
                          Consumer<UserProvider>(
                            builder: (context, userProvider, child) {
                              return WeeklyProgressIndicator(
                                title: 'Journals',
                                indicatorValue: (userProvider.user
                                                ?.writtenJournals?.length ??
                                            0)
                                        .toDouble() /
                                    3.0,
                                progressPercentage:
                                    '${((userProvider.user?.writtenJournals?.length ?? 0).toDouble() / 3.0 * 100).toInt()}',
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
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    final meditationVideos = adminBloc.meditationVideos
                        .where(
                          (video) => video.status == 'Active',
                        )
                        .where(
                          (video) => video.mood == userProvider.user?.mood,
                        )
                        .toList();
                    final firstThreeMeditationVideos =
                        meditationVideos.take(3).toList();

                    if (state is GettingMeditationVideo) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetMeditationVideoFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return SizedBox(
                      height: 180,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: firstThreeMeditationVideos.length,
                        itemBuilder: (context, index) {
                          final video = firstThreeMeditationVideos[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MeditationDetailpageStart(
                                      meditationVideos: video,
                                    ),
                                  ),
                                );
                              },
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
                                    child: Image(
                                      image: NetworkImage(
                                        video.videoIcon ?? '',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    video.title ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(
                                        0xFF2B2B2B,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${video.duration} min',
                                    style: const TextStyle(
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
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const JournalScreen(),
                        ),
                      );
                    },
                  ),
                  Explore(
                    title: 'Positive Declarations',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const PositiveDeclarationsScreen(),
                        ),
                      );
                    },
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const Blog(
                            fromHomePage: true,
                          ),
                        ),
                      );
                    },
                  ),
                  Explore(
                    title: 'Need Help?',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const FaqsScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Gaps.hGap10,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const Blog(
                            fromHomePage: true,
                          ),
                        ),
                      );
                    },
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
            BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                final blog = adminBloc.activeBlogs.take(3).toList();
                if (state is GettingBlog) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetBlogFailed) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return ListView.builder(
                  itemCount: blog.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogDetialPage(
                                blog: blog[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(
                                  0.2,
                                ),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    blog[index].title ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0Xff2B2B2B),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      blog[index].description ?? '',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0Xff2B2B2B),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    blog[index].image ?? '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
