import 'package:flutter/material.dart';
import 'package:mind_labify/features/user/views/meditation_detailpage_submit.dart';
import 'package:mind_labify/models/meditation_video.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';
import 'package:video_player/video_player.dart';

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
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.meditationVideos.video.toString(),
      ),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    setState(() {});
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              _showControls = !_showControls;
                            },
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 251,
                              width: double.infinity,
                              child: VideoPlayer(_controller),
                            ),
                            if (_showControls)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 80.0,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            if (_controller.value.isPlaying) {
                                              _controller.pause();
                                            } else {
                                              _controller.play();
                                            }
                                            _isPlaying = !_isPlaying;
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  VideoProgressIndicator(
                                    padding: const EdgeInsets.only(
                                      top: 80,
                                    ),
                                    _controller,
                                    allowScrubbing: true,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                Gaps.hGap30,
                Text(
                  widget.meditationVideos.title ?? '',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Gaps.hGap30,
                Text(
                  '${widget.meditationVideos.duration ?? ''} Mins',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(
                  height: 144,
                ),
                _isPlaying
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
                                     MeditationDetailpageSubmit(
                                      meditationVideos: widget.meditationVideos,
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
                                if (_isPlaying) {
                                  _controller.pause();
                                  _isPlaying = false;
                                } else {
                                  _controller.play();
                                  _isPlaying = true;
                                }
                              },
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
