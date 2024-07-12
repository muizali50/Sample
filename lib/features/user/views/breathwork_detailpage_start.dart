import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_labify/features/user/views/breathwork_detailpage_submit.dart';
import 'package:mind_labify/models/breathwork_video.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BreathworkDetailpageStart extends StatefulWidget {
  final BreathworkVideo breathworkVideos;
  const BreathworkDetailpageStart({
    super.key,
    required this.breathworkVideos,
  });

  @override
  State<BreathworkDetailpageStart> createState() =>
      _BreathworkDetailpageStartState();
}

class _BreathworkDetailpageStartState extends State<BreathworkDetailpageStart> {
  late YoutubePlayerController _controller;
  bool _isStarted = false;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.breathworkVideos.videoUrl ?? '')!,
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
                    widget.breathworkVideos.title ?? '',
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
                    '${widget.breathworkVideos.duration ?? ''} Mins',
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
                          child: AppPrimaryButton(
                            text: 'Done',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (
                                    context,
                                  ) =>
                                      BreathworkDetailpageSubmit(
                                    breathworkVideos: widget.breathworkVideos,
                                  ),
                                ),
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
