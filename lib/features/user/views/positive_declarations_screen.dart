import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/user/views/create_declaration_screen.dart';
import 'package:mind_labify/features/user/views/declaration_detail_screen.dart';
import 'package:mind_labify/models/declaration_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';

class PositiveDeclarationsScreen extends StatefulWidget {
  const PositiveDeclarationsScreen({super.key});

  @override
  State<PositiveDeclarationsScreen> createState() =>
      _PositiveDeclarationsScreenState();
}

class _PositiveDeclarationsScreenState
    extends State<PositiveDeclarationsScreen> {
  late final AdminBloc adminBloc;
  final TextEditingController searchController = TextEditingController();
  bool _isSearching = false;
  String _searchText = '';
  List<DeclarationModel> filterDeclarationData = [];

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.activeDeclarationCategories.isEmpty) {
      adminBloc.add(
        GetDeclarationCategory(),
      );
    }

    if (adminBloc.activeDeclaration.isEmpty) {
      adminBloc.add(
        GetDeclaration(),
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
        _filterDeclarations();
      },
    );
  }

  void _filterDeclarations() {
    if (_searchText.isEmpty) {
      filterDeclarationData = adminBloc.activeDeclaration;
    } else {
      filterDeclarationData = adminBloc.activeDeclaration
          .where(
            (declaration) => declaration.title!.toLowerCase().contains(
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
        filterDeclarationData = adminBloc.activeDeclaration;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.read<AdminBloc>();
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
                'Positive Declarations',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (
                        context,
                      ) =>
                          const CreateDeclarationScreen(),
                    ),
                  );
                },
                child: const Text(
                  '+ Create your own positive declarations',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(
                      0xFF573926,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 700,
                child: BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is GettingDeclarationCategory) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetDeclarationCategoryFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return DefaultTabController(
                      length: adminBloc.activeDeclarationCategories.length,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              top: 10.0,
                            ),
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
                            tabs: adminBloc.activeDeclarationCategories
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
                              if (state is GettingDeclaration) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is GetDeclarationFailed) {
                                return Center(
                                  child: Text(state.message),
                                );
                              }
                              return SizedBox(
                                height: 600,
                                child: TabBarView(
                                  children:
                                      adminBloc.activeDeclarationCategories.map(
                                    (category) {
                                      final filteredDeclarations =
                                          filterDeclarationData.isNotEmpty
                                              ? filterDeclarationData
                                                  .where(
                                                    (declaration) =>
                                                        declaration
                                                            .declarationCategory ==
                                                        category.name,
                                                  )
                                                  .toList()
                                              : adminBloc.activeDeclaration
                                                  .where(
                                                    (declaration) =>
                                                        declaration
                                                            .declarationCategory ==
                                                        category.name,
                                                  )
                                                  .toList();
                                      return filteredDeclarations.isEmpty
                                          ? const Center(
                                              child: Text(
                                                  'No Positive Declaratios'),
                                            )
                                          : GridView.builder(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                              ),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisExtent: 155,
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                              ),
                                              itemCount:
                                                  filteredDeclarations.length,
                                              itemBuilder: (context, index) {
                                                final declaration =
                                                    filteredDeclarations[index];
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (
                                                          context,
                                                        ) =>
                                                            DeclarationDetailScreen(
                                                          declaration:
                                                              declaration,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      5.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                        0xffffffff,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8.0,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 110,
                                                          width: 140,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  NetworkImage(
                                                                declaration
                                                                    .image
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Gaps.hGap10,
                                                        Text(
                                                          declaration.title
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontFamily: 'Inter',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
