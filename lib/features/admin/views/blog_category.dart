import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/add_blog_category.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/search_field.dart';
import 'package:mind_labify/models/blog_category_model.dart';
import 'package:mind_labify/utils/gaps.dart';

class BlogCategory extends StatefulWidget {
  const BlogCategory({super.key});

  @override
  State<BlogCategory> createState() => _BlogCategoryState();
}

class _BlogCategoryState extends State<BlogCategory> {
  late final AdminBloc adminBloc;
  List<BlogCategoryModel> filterBlogCategoryData = [];
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.blogCategories.isEmpty) {
      adminBloc.add(
        GetBlogCategory(),
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
      filterBlogCategoryData = adminBloc.blogCategories;
    } else {
      filterBlogCategoryData = adminBloc.blogCategories
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
                      'All Blog Categories',
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
                            builder: (context) => const AddBlogCategory(),
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
                    if (state is GettingBlogCategory) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetBlogCategoryFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.blogCategories.isEmpty
                        ? const Center(
                            child: Text(
                              'No Blog Categories',
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
                            rows: filterBlogCategoryData.isNotEmpty
                                ? filterBlogCategoryData
                                    .map(
                                      (blogCategories) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              blogCategories.name ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              blogCategories.status ?? '',
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
                                                            AddBlogCategory(
                                                          blogCategory:
                                                              blogCategories,
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
                                                            'Delete Blog Category',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to delete this blog category?',
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
                                                                  DeleteBlogCategory(
                                                                    blogCategories
                                                                            .blogCategoryId ??
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
                                : adminBloc.blogCategories
                                    .map(
                                      (blogCategories) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              blogCategories.name ?? '',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              blogCategories.status ?? '',
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
                                                            AddBlogCategory(
                                                          blogCategory:
                                                              blogCategories,
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
                                                            'Delete Blog Category',
                                                          ),
                                                          content: const Text(
                                                            'Are you sure you want to delete this blog category?',
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
                                                                  DeleteBlogCategory(
                                                                    blogCategories
                                                                            .blogCategoryId ??
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
