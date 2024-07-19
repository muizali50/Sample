import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/add_journal_category.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/search_field.dart';
import 'package:mind_labify/models/journal_category_model.dart';
import 'package:mind_labify/utils/gaps.dart';

class JournalCategory extends StatefulWidget {
  const JournalCategory({super.key});

  @override
  State<JournalCategory> createState() => _JournalCategoryState();
}

class _JournalCategoryState extends State<JournalCategory> {
  late final AdminBloc adminBloc;
  List<JournalCategoryModel> filterJournalCategoryData = [];
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.journalCategories.isEmpty) {
      adminBloc.add(
        GetJournalCategory(),
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
      filterJournalCategoryData = adminBloc.journalCategories;
    } else {
      filterJournalCategoryData = adminBloc.journalCategories
          .where(
            (category) => category.name!.toLowerCase().contains(
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
                      'All Journal Categories',
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
                            builder: (context) => const AddJournalCategory(),
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
                    if (state is GettingJournalCategory) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetJournalCategoryFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.journalCategories.isEmpty
                        ? const Center(
                            child: Text(
                              'No Journal Categories',
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
                            rows: filterJournalCategoryData.isNotEmpty
                                ? filterJournalCategoryData
                                    .map(
                                      (journalCategories) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              journalCategories.name ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              journalCategories.status ?? '',
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
                                                            AddJournalCategory(
                                                          journalCategory:
                                                              journalCategories,
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
                                                            'Delete Journal Category',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to delete this journal category?',
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
                                                                  DeleteJournalCategory(
                                                                    journalCategories
                                                                            .journalCategoryId ??
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
                                : adminBloc.journalCategories
                                    .map(
                                      (journalCategories) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              journalCategories.name ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              journalCategories.status ?? '',
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
                                                            AddJournalCategory(
                                                          journalCategory:
                                                              journalCategories,
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
                                                            'Delete Journal Category',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to delete this journal category?',
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
                                                                  DeleteJournalCategory(
                                                                    journalCategories
                                                                            .journalCategoryId ??
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
