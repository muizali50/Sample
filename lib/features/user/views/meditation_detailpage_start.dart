import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/user/user_bloc/user_bloc.dart';
import 'package:mind_labify/features/user/views/meditation_detailpage_submit.dart';
import 'package:mind_labify/models/meditation_video.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MeditationDetailpageStart extends StatefulWidget {
  final MeditationVideo meditationVideos;
  const MeditationDetailpageStart({
    super.key,
    required this.meditationVideos,
  });

  @override
  State<MeditationDetailpageStart> createState() =>
      _MeditationDetailpageStartState();
}

class _MeditationDetailpageStartState extends State<MeditationDetailpageStart> {
  late YoutubePlayerController _controller;
  bool _isStarted = false;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.meditationVideos.videoUrl ?? '')!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    _controller.addListener(
      () {
        if (_controller.value.isFullScreen != _isFullscreen) {
          setState(
            () {
              _isFullscreen = _controller.value.isFullScreen;
              if (!_isFullscreen) {
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              }
            },
          );
        }
        if (_controller.value.isPlaying && !_isStarted) {
          setState(
            () {
              _isStarted = true;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: !_isFullscreen
            ? AppBar(
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0,
                elevation: 0,
              )
            : null,
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              _controller.addListener(() {});
            },
          ),
          builder: (context, player) {
            return Column(
              children: [
                player,
                if (!_isFullscreen) Gaps.hGap30,
                if (!_isFullscreen)
                  Text(
                    widget.meditationVideos.title ?? '',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                if (!_isFullscreen) Gaps.hGap30,
                if (!_isFullscreen)
                  Text(
                    '${widget.meditationVideos.duration ?? ''} Mins',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                if (!_isFullscreen)
                  const SizedBox(
                    height: 144,
                  ),
                if (!_isFullscreen)
                  _isStarted
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 34.0,
                          ),
                          child: BlocConsumer<UserBloc, UserState>(
                            listener: (context, state) {
                              if (state is MeditationWatchedVideoLoaded) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (
                                      context,
                                    ) =>
                                        MeditationDetailpageSubmit(
                                      meditationVideos: widget.meditationVideos,
                                    ),
                                  ),
                                );
                              } else if (state
                                  is MeditationWatchedVideoLoadingError) {
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
                              if (state is MeditationWatchedVideoLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return AppPrimaryButton(
                                text: 'Done',
                                onTap: () {
                                  userBloc.add(
                                    MeditationVideoWatched(
                                      widget.meditationVideos.videoId ?? '',
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 34.0,
                          ),
                          child: AppPrimaryButton(
                            text: 'Start',
                            onTap: () {
                              setState(
                                () {
                                  _controller.play();
                                },
                              );
                            },
                          ),
                        ),
              ],
            );
          },
        ));
  }
}
