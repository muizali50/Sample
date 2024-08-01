import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/utils/gaps.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  late final AdminBloc adminBloc;

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
    super.initState();
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
          'Blogs',
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: SizedBox(
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
                                              adminBloc.activeBlogs
                                                  .where(
                                                    (blog) =>
                                                        blog.blogCategory ==
                                                        category.name,
                                                  )
                                                  .toList();
                                          return ListView.builder(
                                            // physics:
                                            //     const NeverScrollableScrollPhysics(),
                                            // shrinkWrap: true,
                                            itemCount: filteredBlogs.length,
                                            itemBuilder: (context, index) {
                                              final blog = filteredBlogs[index];
                                              return Row(
                                                children: [
                                                  Container(
                                                    height: 70,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      // image: DecorationImage(
                                                      //   fit: BoxFit.cover,
                                                      //   image: NetworkImage(
                                                      //     blog.image.toString(),
                                                      //   ),
                                                      // ),
                                                    ),
                                                    child: Image(
                                                      image: NetworkImage(
                                                        blog.image.toString(),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    blog.title.toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
