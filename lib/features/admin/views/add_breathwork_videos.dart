import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/admin_button.dart';
import 'package:mind_labify/models/breathwork_video.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';
import 'package:video_player/video_player.dart';

class AddBreathworkVideos extends StatefulWidget {
  final BreathworkVideo? breathworkVideos;
  const AddBreathworkVideos({
    super.key,
    this.breathworkVideos,
  });

  @override
  State<AddBreathworkVideos> createState() => _AddBreathworkVideosState();
}

class _AddBreathworkVideosState extends State<AddBreathworkVideos> {
  late BreathworkVideo breathworkVideos;
  late final AdminBloc adminBloc;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  String category = '';
  String mood = 'Happy';
  String status = 'Inactive';
  String? videoIcon;
  File? video;
  VideoPlayerController? videoPlayerController;
  final picker = ImagePicker();

  _pickVideo() async {
    final pickedVideo = await picker.pickVideo(
      source: ImageSource.gallery,
    );

    video = File(pickedVideo!.path);
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(video!.path),
    )..initialize().then(
        (_) {
          setState(
            () {},
          );
          videoPlayerController!.play();
        },
      );
  }

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    adminBloc.add(
      GetBreathWorkCategory(),
    );

    if (widget.breathworkVideos != null) {
      _titleController.text = widget.breathworkVideos!.title ?? '';
      _durationController.text = widget.breathworkVideos!.duration ?? '';
      mood = widget.breathworkVideos!.mood ?? '';
      category = widget.breathworkVideos!.breathworkCategory ?? '';
      videoIcon = widget.breathworkVideos!.videoIcon ?? '';
      status = widget.breathworkVideos!.status ?? '';
      video = File(widget.breathworkVideos!.video ?? '');
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.breathworkVideos!.video ?? ''),
      )..initialize().then(
          (_) {
            setState(
              () {},
            );
            videoPlayerController!.play();
          },
        );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.watch<AdminBloc>();
    return Scaffold(
      backgroundColor: const Color(
        0xFFF1F1F1,
      ),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(
            0xFF000000,
          ),
        ),
        title: Text(
          widget.breathworkVideos != null
              ? 'Edit Breathwork Video'
              : 'Add Breathwork Video',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xFFffffff,
            ),
            borderRadius: BorderRadius.circular(
              05,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 500,
                      child: AppTextField(
                        controller: _titleController,
                        hintText: 'Title',
                      ),
                    ),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFEAEAEA,
                        ),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Status:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          DropdownButton<String>(
                            underline: Container(),
                            value: status,
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'Active',
                                child: Text(
                                  'Active',
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Inactive',
                                child: Text(
                                  'Inactive',
                                ),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  status = newValue!;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.hGap35,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 500,
                      child: AppTextField(
                        controller: _durationController,
                        hintText: 'Duration (Minutes)',
                      ),
                    ),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFEAEAEA,
                        ),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Breathwork Category',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            category,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Container(
                                    height: 200,
                                    width: 300,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                      color: const Color(
                                        0xFFffffff,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Select Category',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Color(
                                              0xFF131313,
                                            ),
                                          ),
                                        ),
                                        Gaps.hGap15,
                                        BlocBuilder<AdminBloc, AdminState>(
                                          builder: (context, state) {
                                            if (state
                                                is GettingBreathWorkCategory) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (state
                                                is GetBreathWorkCategoryFailed) {
                                              return Center(
                                                child: Text(
                                                  state.message,
                                                ),
                                              );
                                            }
                                            return Expanded(
                                              child: ListView.builder(
                                                itemCount: adminBloc
                                                    .breathWorks.length,
                                                itemBuilder: (context, index) {
                                                  return Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        setState(
                                                          () {
                                                            category = adminBloc
                                                                    .breathWorks[
                                                                        index]
                                                                    .title ??
                                                                '';
                                                          },
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        adminBloc
                                                                .breathWorks[
                                                                    index]
                                                                .title ??
                                                            '',
                                                        style: const TextStyle(
                                                          fontFamily: 'Inter',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(
                                                            0xFF131313,
                                                          ),
                                                        ),
                                                      ),
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
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.hGap35,
                Container(
                  width: 500,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFEAEAEA,
                    ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Mood',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      DropdownButton<String>(
                        underline: Container(),
                        value: mood,
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                        ),
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'Happy',
                            child: Text(
                              'Happy',
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Emotional',
                            child: Text(
                              'Emotional',
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Confused',
                            child: Text(
                              'Confused',
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Sad',
                            child: Text(
                              'Sad',
                            ),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              mood = newValue!;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Gaps.hGap35,
                const Text(
                  'Video Icon',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(
                      0xFF371B34,
                    ),
                  ),
                ),
                Gaps.hGap15,
                Row(
                  children: [
                    DottedBorder(
                      dashPattern: const [4, 4],
                      strokeWidth: 2,
                      color: const Color(
                        0xFF000000,
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              final pickedFile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );

                              if (pickedFile != null) {
                                final iconUrl = pickedFile.path;
                                setState(
                                  () {
                                    videoIcon = iconUrl;
                                  },
                                );
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(
                                  0xFF000000,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  color: Color(
                                    0xFFffffff,
                                  ),
                                  Icons.add,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    videoIcon != null
                        ? Image.network(videoIcon!, width: 50, height: 50)
                        : Container(),
                  ],
                ),
                Gaps.hGap35,
                const Text(
                  'Upload Breathwork Video',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(
                      0xFF371B34,
                    ),
                  ),
                ),
                Gaps.hGap15,
                Row(
                  children: [
                    DottedBorder(
                      dashPattern: const [4, 4],
                      strokeWidth: 2,
                      color: const Color(
                        0xFF000000,
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _pickVideo();
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(
                                  0xFF000000,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  color: Color(
                                    0xFFffffff,
                                  ),
                                  Icons.add,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (video != null)
                      videoPlayerController!.value.isInitialized
                          ? SizedBox(
                              height: 100,
                              width: 100,
                              child: AspectRatio(
                                aspectRatio:
                                    videoPlayerController!.value.aspectRatio,
                                child: VideoPlayer(videoPlayerController!),
                              ),
                            )
                          : const CircularProgressIndicator()
                  ],
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is CreateBreathWorkVideoSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Breathwork video created successfully',
                          ),
                        ),
                      );
                      _titleController.clear();
                      _durationController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is CreateBreathWorkVideoFailed) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateBreathWorkVideoSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Breathwork video updated successfully',
                          ),
                        ),
                      );
                      _titleController.clear();
                      _durationController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is UpdateBreathWorkVideoFailed) {
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
                    if (state is CreatingBreathWorkVideo ||
                        state is UpdatingBreathWorkVideo) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text:
                            widget.breathworkVideos != null ? 'Update' : 'Add',
                        onTap: () {
                          if (_titleController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the title',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_durationController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the duration',
                                ),
                              ),
                            );
                            return;
                          }
                          if (category.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the category',
                                ),
                              ),
                            );
                            return;
                          }
                          if (video == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the video',
                                ),
                              ),
                            );
                            return;
                          }
                          if (videoIcon!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the icon',
                                ),
                              ),
                            );
                            return;
                          }
                          if (widget.breathworkVideos != null) {
                            adminBloc.add(
                              UpdateBreathWorkVideo(
                                BreathworkVideo(
                                  videoId: widget.breathworkVideos!.videoId,
                                  title: _titleController.text,
                                  status: status,
                                  duration: _durationController.text,
                                  breathworkCategory: category,
                                  mood: mood,
                                  videoIcon: videoIcon,
                                  video: video!.path,
                                ),
                                videoIcon == widget.breathworkVideos!.videoIcon
                                    ? null
                                    : XFile(videoIcon!),
                                video!.path == widget.breathworkVideos!.video
                                    ? null
                                    : XFile(video!.path),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              CreateBreathWorkVideo(
                                BreathworkVideo(
                                  videoId: DateTime.now().toIso8601String(),
                                  title: _titleController.text,
                                  status: status,
                                  duration: _durationController.text,
                                  breathworkCategory: category,
                                  mood: mood,
                                  videoIcon: videoIcon,
                                  video: video!.path,
                                ),
                                XFile(videoIcon!),
                                XFile(video!.path),
                              ),
                            );
                          }
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
