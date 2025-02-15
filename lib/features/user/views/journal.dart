import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/user/views/write_journals.dart';
import 'package:mind_labify/models/journal_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  late final AdminBloc adminBloc;
  final TextEditingController searchController = TextEditingController();
  bool _isSearching = false;
  String _searchText = '';
  List<JournalModel> filterJournalData = [];

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.activeJournalCategories.isEmpty) {
      adminBloc.add(
        GetJournalCategory(),
      );
    }

    if (adminBloc.activeJournals.isEmpty) {
      adminBloc.add(
        GetJournal(),
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
        _filterJournals();
      },
    );
  }

  void _filterJournals() {
    if (_searchText.isEmpty) {
      filterJournalData = adminBloc.activeJournals;
    } else {
      filterJournalData = adminBloc.activeJournals
          .where(
            (journal) => journal.title!.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  void clearSearch() {
    searchController.clear();
    setState(
      () {
        filterJournalData = adminBloc.activeJournals;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: _isSearching
            ? IconButton(
                onPressed: () {
                  setState(
                    () {
                      _isSearching = false;
                    },
                  );
                  clearSearch();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              )
            : null,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Color(
            0xFF371B34,
          ),
        ),
        title: _isSearching
            ? SizedBox(
                height: 55,
                child: AppTextField(
                  isAutoFocue: true,
                  isBorder: true,
                  controller: searchController,
                  hintText: 'Search',
                ),
              )
            : const Text(
                'Journals',
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  _isSearching = true;
                },
              );
            },
            icon: Icon(
              color: Theme.of(context).colorScheme.primary,
              CupertinoIcons.search,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 700,
                  child: BlocBuilder<AdminBloc, AdminState>(
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
                      return DefaultTabController(
                        length: adminBloc.activeJournalCategories.length,
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
                              tabs: adminBloc.activeJournalCategories
                                  .map(
                                    (category) => Tab(
                                      text: category.name,
                                    ),
                                  )
                                  .toList(),
                            ),
                            Gaps.hGap10,
                            BlocBuilder<AdminBloc, AdminState>(
                              builder: (context, state) {
                                if (state is GettingJournal) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GetJournalFailed) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                }
                                return SizedBox(
                                  height: 600,
                                  child: TabBarView(
                                    children:
                                        adminBloc.activeJournalCategories.map(
                                      (category) {
                                        final filteredJournals =
                                            filterJournalData.isNotEmpty
                                                ? filterJournalData
                                                    .where(
                                                      (journal) =>
                                                          journal
                                                              .journalCategory ==
                                                          category.name,
                                                    )
                                                    .toList()
                                                : adminBloc.activeJournals
                                                    .where(
                                                      (journal) =>
                                                          journal
                                                              .journalCategory ==
                                                          category.name,
                                                    )
                                                    .toList();
                                        return ListView.builder(
                                          itemCount: filteredJournals.length,
                                          itemBuilder: (context, index) {
                                            final journal =
                                                filteredJournals[index];
                                            return Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 15,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                color: const Color(
                                                  0xFFC8D1D1,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    journal.title.toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                                  ),
                                                  Gaps.hGap20,
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 30.0,
                                                    ),
                                                    child: AppPrimaryButton(
                                                      buttonColor: 0xFFF4F2E8,
                                                      text: 'Answer',
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (
                                                              context,
                                                            ) =>
                                                                WriteJournals(
                                                              journal: journal,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
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
