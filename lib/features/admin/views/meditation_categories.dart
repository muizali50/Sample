import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/add_meditation_category.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/search_field.dart';
import 'package:mind_labify/models/meditation_model.dart';
import 'package:mind_labify/utils/gaps.dart';

class MeditationCategories extends StatefulWidget {
  const MeditationCategories({super.key});

  @override
  State<MeditationCategories> createState() => _MeditationCategoriesState();
}

class _MeditationCategoriesState extends State<MeditationCategories> {
  late final AdminBloc adminBloc;
  List<MeditationModel> filterMeditationData = [];
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.meditations.isEmpty) {
      adminBloc.add(
        GetMeditationCategory(),
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
      filterMeditationData = adminBloc.meditations;
    } else {
      filterMeditationData = adminBloc.meditations
          .where(
            (meditation) => meditation.title!.toLowerCase().contains(
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
                      'All Meditation Categories',
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
                            builder: (context) => const AddMeditationCategory(),
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
                          '+ Add Category',
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
                    if (state is GettingMeditationCategory) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetBreathWorkCategoryFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.meditations.isEmpty
                        ? const Center(
                            child: Text(
                              'No Meditation Categories',
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
                                  'Name',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Status',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actions',
                                ),
                              ),
                            ],
                            rows: filterMeditationData.isNotEmpty
                                ? filterMeditationData
                                    .map(
                                      (meditations) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              meditations.title ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              meditations.status ?? '',
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
                                                            AddMeditationCategory(
                                                          meditation:
                                                              meditations,
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
                                                            'Delete Meditation Category',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to delete this meditation category?',
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
                                                                  DeleteMeditationCategory(
                                                                    meditations
                                                                            .meditationId ??
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
                                : adminBloc.meditations
                                    .map(
                                      (meditations) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              meditations.title ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              meditations.status ?? '',
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
                                                            AddMeditationCategory(
                                                          meditation:
                                                              meditations,
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
                                                            'Delete Meditation Category',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to delete this meditation category?',
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
                                                                  DeleteMeditationCategory(
                                                                    meditations
                                                                            .meditationId ??
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
