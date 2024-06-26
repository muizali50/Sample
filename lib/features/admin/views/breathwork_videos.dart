import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/add_breathwork_videos.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/search_field.dart';
import 'package:mind_labify/models/breathwork_video.dart';
import 'package:mind_labify/utils/gaps.dart';

class BreathworkVideos extends StatefulWidget {
  const BreathworkVideos({super.key});

  @override
  State<BreathworkVideos> createState() => _BreathworkVideosState();
}

class _BreathworkVideosState extends State<BreathworkVideos> {
  late final AdminBloc adminBloc;
  final TextEditingController searchController = TextEditingController();
  List<BreathworkVideo> filterBreathworkVideos = [];
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.breathWorks.isEmpty) {
      adminBloc.add(
        GetBreathworkVideo(),
      );
    }

    searchController.addListener(
      _onSearchChanged,
    );
    super.initState();
  }

  void _onSearchChanged() {
    setState(
      () {
        _searchText = searchController.text;
        _filterUsers();
      },
    );
  }

  void _filterUsers() {
    if (_searchText.isEmpty) {
      filterBreathworkVideos = adminBloc.breathworkVideos;
    } else {
      filterBreathworkVideos = adminBloc.breathworkVideos
          .where(
            (breathwork) => breathwork.title!.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF1F1F1,
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
            vertical: 55,
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
                  children: [
                    const Text(
                      'All Breathwork Videos',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(
                          0xFF131313,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddBreathworkVideos(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF000000,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: const Text(
                          '+ Add Video',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xFFffffff,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 277,
                      child: SearchField(
                        controller: searchController,
                      ),
                    ),
                  ],
                ),
                Gaps.hGap30,
                BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is GettingBreathworkVideo) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetBreathworkVideoFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.breathworkVideos.isEmpty
                        ? const Center(
                            child: Text(
                              'No Breathwork Videos',
                            ),
                          )
                        : DataTable(
                            headingTextStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xFF131313,
                              ),
                            ),
                            dataTextStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xFF131313,
                              ),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Title',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Status',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Duration',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Category',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Mood',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actions',
                                ),
                              ),
                            ],
                            rows: filterBreathworkVideos.isNotEmpty
                                ? filterBreathworkVideos
                                    .map(
                                      (breathworkVideos) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              breathworkVideos.title ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              breathworkVideos.status ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '${breathworkVideos.duration.toString()} Mins',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              breathworkVideos
                                                      .breathworkCategory ??
                                                  '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              breathworkVideos.mood ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddBreathworkVideos(
                                                          breathworkVideos:
                                                              breathworkVideos,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(
                                                        0xFF131313,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            'Delete Breathwork Video',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to delete this video?',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Cancel',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                    0xFF131313,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                adminBloc.add(
                                                                  DeleteBreathworkVideo(
                                                                    breathworkVideos
                                                                            .videoId ??
                                                                        '',
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Delete',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                    0xFF131313,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(
                                                        0xFF131313,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList()
                                : adminBloc.breathworkVideos
                                    .map(
                                      (breathworkVideos) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              breathworkVideos.title ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              breathworkVideos.status ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              breathworkVideos.duration ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              breathworkVideos
                                                      .breathworkCategory ??
                                                  '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              breathworkVideos.mood ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddBreathworkVideos(
                                                          breathworkVideos:
                                                              breathworkVideos,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(
                                                        0xFF131313,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            'Delete Breathwork Video',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to delete this video?',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Cancel',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                    0xFF131313,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                adminBloc.add(
                                                                  DeleteBreathworkVideo(
                                                                    breathworkVideos
                                                                            .videoId ??
                                                                        '',
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Delete',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                    0xFF131313,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(
                                                        0xFF131313,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
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
