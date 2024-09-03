import 'package:flutter/material.dart';
import 'package:mind_labify/features/authentication/bloc/authentication_bloc.dart';
import 'package:mind_labify/features/user/views/sub_features/home/widgets/weekly_progress_indicator.dart';
import 'package:mind_labify/features/user/views/sub_features/progress_tracking/widgets/breathwork_box.dart';
import 'package:mind_labify/features/user/views/sub_features/progress_tracking/widgets/journal_box.dart';
import 'package:mind_labify/features/user/views/sub_features/progress_tracking/widgets/meditation_box.dart';
import 'package:mind_labify/user_provider.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:provider/provider.dart';

class ProgressTrackingScreen extends StatefulWidget {
  const ProgressTrackingScreen({super.key});

  @override
  State<ProgressTrackingScreen> createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              'Hi',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Text(
                  '${userProvider.user?.name}!',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: 'Inter',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: const Color(
                      0xffC8D1D1,
                    ),
                  ),
                  child: Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      final meditationProgress =
                          (userProvider.user?.meditationWatchedVideos?.length ??
                                      0)
                                  .toDouble() /
                              5.0;
                      final breathworkProgress =
                          (userProvider.user?.breathworkWatchedVideos?.length ??
                                      0)
                                  .toDouble() /
                              5.0;
                      final journalsProgress =
                          (userProvider.user?.writtenJournals?.length ?? 0)
                                  .toDouble() /
                              3.0;

                      final averageProgress = (meditationProgress +
                              breathworkProgress +
                              journalsProgress) /
                          3.0;
                      final averagePercentage = (averageProgress * 100).toInt();
                      return WeeklyProgressIndicator(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        title: 'Your mindfulness practices for this week ',
                        indicatorValue: averageProgress,
                        progressPercentage: averagePercentage.toString(),
                      );
                    },
                  ),
                ),
                Gaps.hGap20,
                const Text(
                  'Breathwork',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(
                      0xff573926,
                    ),
                  ),
                ),
                Gaps.hGap15,
                const BreathworkBox(),
                Gaps.hGap20,
                const Text(
                  'Journal',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(
                      0xff573926,
                    ),
                  ),
                ),
                Gaps.hGap15,
                const JournalBox(),
                Gaps.hGap20,
                const Text(
                  'Meditation',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(
                      0xff573926,
                    ),
                  ),
                ),
                Gaps.hGap15,
                const MeditationBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
