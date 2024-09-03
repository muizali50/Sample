import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/authentication/bloc/authentication_bloc.dart';
import 'package:mind_labify/features/user/views/meditation_detailpage_start.dart';
import 'package:mind_labify/user_provider.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MeditationBox extends StatefulWidget {
  const MeditationBox({super.key});

  @override
  State<MeditationBox> createState() => _MeditationBoxState();
}

class _MeditationBoxState extends State<MeditationBox> {
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
    if (adminBloc.meditationVideos.isEmpty) {
      adminBloc.add(
        GetMeditationVideo(),
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
            final activeVideos = adminBloc.meditationVideos
                .where(
                  (video) => video.status == 'Active',
                )
                .where(
                  (video) => video.mood == userProvider.user?.mood,
                )
                .toList();
            final filteredVideos = activeVideos.take(5).toList();
            if (state is GettingMeditationVideo) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetMeditationCategoryFailed) {
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
                      final video = filteredVideos[index];
                      return filteredVideos.isEmpty
                          ? const Center(
                              child: Text(
                                'no video',
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (
                                        context,
                                      ) =>
                                          MeditationDetailpageStart(
                                        meditationVideos: video,
                                      ),
                                    ),
                                  );
                                },
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              video.title.toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                  0xFF000000,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${video.duration} Mins',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 90,
                                        width: 93,
                                        child: Image(
                                          image: NetworkImage(
                                            video.videoIcon.toString(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
