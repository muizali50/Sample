import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/authentication/bloc/authentication_bloc.dart';
import 'package:mind_labify/features/user/views/meditation_detailpage_start.dart';
import 'package:mind_labify/user_provider.dart';
import 'package:mind_labify/utils/gaps.dart';

class Meditation extends StatefulWidget {
  const Meditation({super.key});

  @override
  State<Meditation> createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> with TickerProviderStateMixin {
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

    adminBloc = context.read<AdminBloc>();
    if (adminBloc.meditationVideos.isEmpty) {
      adminBloc.add(
        GetMeditationVideo(),
      );
    }

    if (adminBloc.activeMeditations.isEmpty) {
      adminBloc.add(
        GetMeditationCategory(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5DFD2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: Theme.of(context).colorScheme.secondary,
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
            Text(
              'Sanya!',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: 'Inter',
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.hGap20,
                const Text(
                  'Recommended for you!',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(
                      0xFF2B2B2B,
                    ),
                  ),
                ),
                Gaps.hGap15,
                BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    final filteredVideos = adminBloc.meditationVideos
                        .where(
                          (video) => video.mood == userProvider.user!.mood!,
                        )
                        .where(
                          (video) => video.status == 'Active',
                        )
                        .toList();
                    if (state is GettingMeditationVideo) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is GetMeditationVideoFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
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
                                      MeditationDetailpageStart(
                                    meditationVideos: filteredVideos.first,
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
                                        filteredVideos.first.title.toString(),
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
                                        '${filteredVideos.first.duration.toString()} Mins',
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
                                        filteredVideos.first.videoIcon
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                ),
                Gaps.hGap20,
                SizedBox(
                  height: 500,
                  child: BlocBuilder<AdminBloc, AdminState>(
                    builder: (context, state) {
                      if (state is GettingMeditationCategory) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetMeditationCategoryFailed) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      return DefaultTabController(
                        length: adminBloc.activeMeditations.length,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabBar(
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              indicatorSize: TabBarIndicatorSize.tab,
                              dividerColor: Colors.transparent,
                              indicator: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    16,
                                  ),
                                ),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(
                                  0xFF393939,
                                ),
                              ),
                              labelStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                              tabs: adminBloc.activeMeditations
                                  .map(
                                    (meditation) => Tab(
                                      text: meditation.title,
                                    ),
                                  )
                                  .toList(),
                            ),
                            BlocBuilder<AdminBloc, AdminState>(
                              builder: (context, state) {
                                if (state is GettingMeditationVideo) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is GetMeditationCategoryFailed) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                }
                                return Expanded(
                                  child: TabBarView(
                                    children: adminBloc.activeMeditations.map(
                                      (meditation) {
                                        final filteredVideos = adminBloc
                                            .meditationVideos
                                            .where(
                                              (video) =>
                                                  video.meditationCategory ==
                                                  meditation.title,
                                            )
                                            .where(
                                              (video) =>
                                                  video.status == 'Active',
                                            )
                                            .toList();
                                        return ListView.builder(
                                          itemCount: filteredVideos.length,
                                          itemBuilder: (context, index) {
                                            final video = filteredVideos[index];
                                            return Padding(
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
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              video.title
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                  0xFF000000,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${video.duration} Mins',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Theme.of(
                                                                        context)
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
                                                            video.videoIcon
                                                                .toString(),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ).toList(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
