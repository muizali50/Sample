import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/user/views/blog_detial_page.dart';
import 'package:mind_labify/models/blog_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  late final AdminBloc adminBloc;
  final TextEditingController searchController = TextEditingController();
  bool _isSearching = false;
  String _searchText = '';
  List<BlogModel> filterBlogData = [];

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.activeBlogCategories.isEmpty) {
      adminBloc.add(
        GetBlogCategory(),
      );
    }

    if (adminBloc.activeBlogs.isEmpty) {
      adminBloc.add(
        GetBlog(),
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
        _filterBlogs();
      },
    );
  }

  void _filterBlogs() {
    if (_searchText.isEmpty) {
      filterBlogData = adminBloc.activeBlogs;
    } else {
      filterBlogData = adminBloc.activeBlogs
          .where(
            (blog) => blog.title!.toLowerCase().contains(
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
        filterBlogData = adminBloc.activeBlogs;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                'Blogs',
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
              SizedBox(
                height: 700,
                child: BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is GettingBlogCategory) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetBlogCategoryFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return DefaultTabController(
                      length: adminBloc.activeBlogCategories.length,
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
                            tabs: adminBloc.activeBlogCategories
                                .map(
                                  (category) => Tab(
                                    text: category.name,
                                  ),
                                )
                                .toList(),
                          ),
                          Gaps.hGap10,
                          Container(
                            color: const Color(
                              0xFFffffff,
                            ),
                            padding: const EdgeInsets.all(
                              15,
                            ),
                            child: BlocBuilder<AdminBloc, AdminState>(
                              builder: (context, state) {
                                if (state is GettingBlog) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GetBlogFailed) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                }
                                return SizedBox(
                                  height: 600,
                                  child: TabBarView(
                                    children:
                                        adminBloc.activeBlogCategories.map(
                                      (category) {
                                        final filteredBlogs =
                                            filterBlogData.isNotEmpty
                                                ? filterBlogData
                                                    .where(
                                                      (blog) =>
                                                          blog.blogCategory ==
                                                          category.name,
                                                    )
                                                    .toList()
                                                : adminBloc.activeBlogs
                                                    .where(
                                                      (blog) =>
                                                          blog.blogCategory ==
                                                          category.name,
                                                    )
                                                    .toList();
                                        return filteredBlogs.isEmpty
                                            ? const Center(
                                                child: Text('No Blogs'),
                                              )
                                            : ListView.builder(
                                                itemCount: filteredBlogs.length,
                                                itemBuilder: (context, index) {
                                                  final blog =
                                                      filteredBlogs[index];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 5.0,
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (
                                                              context,
                                                            ) =>
                                                                BlogDetialPage(
                                                              blog: blog,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 70,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    NetworkImage(
                                                                  blog.image
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            blog.title
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
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
                          )
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
    );
  }
}
