import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/models/faqs_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  late final AdminBloc adminBloc;
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';
  List<FAQsModel> filterFaqsData = [];

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.activefaqsCategories.isEmpty) {
      adminBloc.add(
        GetFAQsCategory(),
      );
    }

    if (adminBloc.activefaqs.isEmpty) {
      adminBloc.add(
        GetFAQs(),
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
        _filterFaqs();
      },
    );
  }

  void _filterFaqs() {
    if (_searchText.isEmpty) {
      filterFaqsData = adminBloc.activefaqs;
    } else {
      filterFaqsData = adminBloc.activefaqs
          .where(
            (faq) => faq.title!.toLowerCase().contains(
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
        filterFaqsData = adminBloc.activefaqs;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Color(
            0xFF371B34,
          ),
        ),
        title: const Text(
          'FAQ',
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  isBorder: true,
                  controller: searchController,
                  hintText: 'Search',
                ),
                Gaps.hGap20,
                SizedBox(
                  height: 700,
                  child: BlocBuilder<AdminBloc, AdminState>(
                    builder: (context, state) {
                      if (state is GettingFAQsCategory) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetFAQsCategoryFailed) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      return DefaultTabController(
                        length: adminBloc.activefaqsCategories.length,
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
                              tabs: adminBloc.activefaqsCategories
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
                                if (state is GettingFAQs) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GetFAQsFailed) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                }
                                return SizedBox(
                                  height: 600,
                                  child: TabBarView(
                                    children:
                                        adminBloc.activefaqsCategories.map(
                                      (category) {
                                        final filteredFaqs =
                                            filterFaqsData.isNotEmpty
                                                ? filterFaqsData
                                                    .where(
                                                      (faq) =>
                                                          faq.faqsCategory ==
                                                          category.name,
                                                    )
                                                    .toList()
                                                : adminBloc.activefaqs
                                                    .where(
                                                      (faq) =>
                                                          faq.faqsCategory ==
                                                          category.name,
                                                    )
                                                    .toList();
                                        return ListView.builder(
                                          itemCount: filteredFaqs.length,
                                          itemBuilder: (context, index) {
                                            final faq = filteredFaqs[index];
                                            return Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                  0xFFffffff,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  12,
                                                ),
                                              ),
                                              child: ExpansionTile(
                                                shape: const Border(
                                                  top: BorderSide.none,
                                                  bottom: BorderSide.none,
                                                  left: BorderSide.none,
                                                  right: BorderSide.none,
                                                ),
                                                tilePadding:
                                                    const EdgeInsets.only(
                                                  // top: 10,
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                childrenPadding:
                                                    const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 20,
                                                ),
                                                title: Text(
                                                  faq.title.toString(),
                                                  style: const TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                children: [
                                                  const Divider(
                                                    color: Color.fromARGB(
                                                        255, 231, 231, 231),
                                                  ),
                                                  Gaps.hGap10,
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      faq.description
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
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
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
