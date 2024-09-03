import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/authentication/bloc/authentication_bloc.dart';
import 'package:mind_labify/features/user/views/breathwork_detailpage_start.dart';
import 'package:mind_labify/user_provider.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BreathworkBox extends StatefulWidget {
  const BreathworkBox({super.key});

  @override
  State<BreathworkBox> createState() => _BreathworkBoxState();
}

class _BreathworkBoxState extends State<BreathworkBox> {
  late final UserProvider userProvider;
  late final AuthenticationBloc authenticationBloc;
  late final AdminBloc adminBloc;
  late final PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      authenticationBloc.add(
        const GetUser(),
      );
    }
    controller = PageController();
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.breathworkVideos.isEmpty) {
      adminBloc.add(
        GetBreathworkVideo(),
      );
    }
    super.initState();
    controller.addListener(
      () {
        // Safely handle the controller.page value
        final page = controller.page;
        if (page != null && page.isFinite) {
          setState(
            () {
              currentPage = page.toInt();
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose of the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.read<AdminBloc>();
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            final activeVideos = adminBloc.breathworkVideos
                .where(
                  (video) => video.status == 'Active',
                )
                .where(
                  (video) => video.mood == userProvider.user?.mood,
                )
                .toList();
            final filteredVideos = activeVideos.take(5).toList();
            if (state is GettingBreathworkVideo) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetBreathworkVideoFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            return Column(
              children: [
                SizedBox(
                  height: 105,
                  child: PageView.builder(
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    controller: controller,
                    itemCount:
                        filteredVideos.isEmpty ? 1 : filteredVideos.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      return filteredVideos.isEmpty
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 21,
                                vertical: 23,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD0C958).withOpacity(
                                  0.45,
                                ),
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'no videos',
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (
                                      context,
                                    ) =>
                                        BreathworkDetailpageStart(
                                      breathworkVideos: filteredVideos[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 21,
                                  vertical: 23,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD0C958).withOpacity(
                                    0.45,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredVideos[index].title ?? '',
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: Color(
                                              0xFFF4F2E8,
                                            ),
                                          ),
                                        ),
                                        Gaps.hGap15,
                                        Text(
                                          '${filteredVideos[index].duration ?? ''} Mins',
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(
                                              0xFFF4F2E8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 71,
                                      width: 75,
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            filteredVideos[index].videoIcon ??
                                                ''),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                ),
                Gaps.hGap15,
                SmoothPageIndicator(
                  controller: controller,
                  count: filteredVideos.isEmpty ? 1 : filteredVideos.length,
                  effect: ExpandingDotsEffect(
                    radius: 0,
                    dotHeight: 5,
                    dotWidth: 8,
                    spacing: 10,
                    dotColor: const Color(
                      0xFF979797,
                    ),
                    activeDotColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
