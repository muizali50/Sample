import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/user/views/navigation_menu.dart';
import 'package:mind_labify/models/breathwork_video.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class BreathworkDetailpageSubmit extends StatefulWidget {
  final BreathworkVideo breathworkVideos;
  const BreathworkDetailpageSubmit({
    super.key,
    required this.breathworkVideos,
  });

  @override
  State<BreathworkDetailpageSubmit> createState() =>
      _BreathworkDetailpageSubmitState();
}

class _BreathworkDetailpageSubmitState
    extends State<BreathworkDetailpageSubmit> {
  late final AdminBloc adminBloc;

  String selectedReaction = '';
  void updateReaction(
    String reaction,
  ) {
    setState(
      () {
        selectedReaction = reaction;
      },
    );
  }

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.watch<AdminBloc>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  color: const Color(
                    0xFFffffff,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "You've just finished:",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(
                            0xFF000000,
                          ),
                        ),
                      ),
                      const Image(
                        height: 251,
                        width: 302,
                        image: AssetImage(
                          'assets/images/breath2.png',
                        ),
                      ),
                      const Text(
                        'Deep Breath Dynamics',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(
                            0xFF000000,
                          ),
                        ),
                      ),
                      Gaps.hGap10,
                      const Text(
                        '2-5 Mins',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(
                            0xFF000000,
                          ),
                        ),
                      ),
                      Gaps.hGap40,
                      const Text(
                        'How do you feel?',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(
                            0xFF000000,
                          ),
                        ),
                      ),
                      Gaps.hGap15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              updateReaction(
                                'happy',
                              );
                            },
                            child: const Image(
                              height: 50,
                              color: Color(
                                0xFF357343,
                              ),
                              width: 50,
                              image: AssetImage(
                                'assets/icons/s_happy.png',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              updateReaction(
                                'okay',
                              );
                            },
                            child: const Image(
                              color: Color(
                                0xFF656565,
                              ),
                              height: 50,
                              width: 50,
                              image: AssetImage(
                                'assets/icons/s_normal.png',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              updateReaction(
                                'sad',
                              );
                            },
                            child: const Image(
                              color: Color(
                                0xFFD79152,
                              ),
                              height: 50,
                              width: 50,
                              image: AssetImage(
                                'assets/icons/s_sad.png',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              updateReaction(
                                'angry',
                              );
                            },
                            child: const Image(
                              color: Color(
                                0xFFFF0303,
                              ),
                              height: 50,
                              width: 50,
                              image: AssetImage(
                                'assets/icons/s_tired.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is BreathworkVideoReactionUpdated) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Reaction submitted successfully',
                          ),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              const BottomNavBar(),
                        ),
                      );
                    } else if (state is BreathworkVideoReactionUpdatedFailed) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdatingBreathworkVideoReaction) {
                      return const CircularProgressIndicator();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 34.0,
                      ),
                      child: AppPrimaryButton(
                        text: 'Submit',
                        onTap: () {
                          if (selectedReaction.isEmpty) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please submit the reaction',
                                ),
                              ),
                            );
                            return;
                          }
                          adminBloc.add(
                            UpdateBreathWorkVideoReaction(
                              widget.breathworkVideos.videoId.toString(),
                              selectedReaction,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
