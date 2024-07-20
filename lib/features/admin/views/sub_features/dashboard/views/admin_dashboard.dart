import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_labify/features/admin/views/all_stressors.dart';
import 'package:mind_labify/features/admin/views/blog_category.dart';
import 'package:mind_labify/features/admin/views/blogs.dart';
import 'package:mind_labify/features/admin/views/breathwork_categories.dart';
import 'package:mind_labify/features/admin/views/breathwork_videos.dart';
import 'package:mind_labify/features/admin/views/declaration_categories.dart';
import 'package:mind_labify/features/admin/views/declarations.dart';
import 'package:mind_labify/features/admin/views/faqs.dart';
import 'package:mind_labify/features/admin/views/faqs_catagories.dart';
import 'package:mind_labify/features/admin/views/journal.dart';
import 'package:mind_labify/features/admin/views/journal_category.dart';
import 'package:mind_labify/features/admin/views/meditation_categories.dart';
import 'package:mind_labify/features/admin/views/meditation_videos.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/views/all_users.dart';
import 'package:mind_labify/features/admin/views/sub_features/dashboard/widgets/dashboard_fields.dart';
import 'package:mind_labify/utils/gaps.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const AllUsers(),
    const AllStressors(),
    const BreathworkCategories(),
    const MeditationCategories(),
    const BreathworkVideos(),
    const MeditationVideos(),
    const BlogCategory(),
    const Blogs(),
    const JournalCategory(),
    const Journal(),
    const DeclarationCategory(),
    const Declarations(),
    const FAQsCategory(),
    const FAQs(),
  ];

  void _onItemTapped(
    int index,
  ) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 305,
            color: const Color(
              0xFF000000,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      left: 25,
                      right: 25,
                    ),
                    child: Text(
                      'Admin Panel',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Gaps.hGap35,
                  DashboardFields(
                    icon: Icons.person,
                    onTap: () => _onItemTapped(0),
                    iconColor: _selectedIndex == 0 ? 0xFF000000 : 0xFFffffff,
                    title: 'Users',
                    titleColor: _selectedIndex == 0 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 0 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: CupertinoIcons.doc_append,
                    onTap: () => _onItemTapped(1),
                    iconColor: _selectedIndex == 1 ? 0xFF000000 : 0xFFffffff,
                    title: 'Stressors',
                    titleColor: _selectedIndex == 1 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 1 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.dashboard_rounded,
                    onTap: () => _onItemTapped(2),
                    iconColor: _selectedIndex == 2 ? 0xFF000000 : 0xFFffffff,
                    title: 'Breathwork Category',
                    titleColor: _selectedIndex == 2 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 2 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.dashboard_rounded,
                    onTap: () => _onItemTapped(3),
                    iconColor: _selectedIndex == 3 ? 0xFF000000 : 0xFFffffff,
                    title: 'Meditation Category',
                    titleColor: _selectedIndex == 3 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 3 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.play_arrow_outlined,
                    onTap: () => _onItemTapped(4),
                    iconColor: _selectedIndex == 4 ? 0xFF000000 : 0xFFffffff,
                    title: 'Breathwork Videos',
                    titleColor: _selectedIndex == 4 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 4 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.play_arrow_outlined,
                    onTap: () => _onItemTapped(5),
                    iconColor: _selectedIndex == 5 ? 0xFF000000 : 0xFFffffff,
                    title: 'Meditation Videos',
                    titleColor: _selectedIndex == 5 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 5 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.edit_document,
                    onTap: () => _onItemTapped(6),
                    iconColor: _selectedIndex == 6 ? 0xFF000000 : 0xFFffffff,
                    title: 'Blog Category',
                    titleColor: _selectedIndex == 6 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 6 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.edit_document,
                    onTap: () => _onItemTapped(7),
                    iconColor: _selectedIndex == 7 ? 0xFF000000 : 0xFFffffff,
                    title: 'Blogs',
                    titleColor: _selectedIndex == 7 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 7 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.edit_document,
                    onTap: () => _onItemTapped(8),
                    iconColor: _selectedIndex == 8 ? 0xFF000000 : 0xFFffffff,
                    title: 'Journal Category',
                    titleColor: _selectedIndex == 8 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 8 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.edit_document,
                    onTap: () => _onItemTapped(9),
                    iconColor: _selectedIndex == 9 ? 0xFF000000 : 0xFFffffff,
                    title: 'Journals',
                    titleColor: _selectedIndex == 9 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 9 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.file_copy,
                    onTap: () => _onItemTapped(10),
                    iconColor: _selectedIndex == 10 ? 0xFF000000 : 0xFFffffff,
                    title: 'Declarations Category',
                    titleColor: _selectedIndex == 10 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 10 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.file_copy,
                    onTap: () => _onItemTapped(11),
                    iconColor: _selectedIndex == 11 ? 0xFF000000 : 0xFFffffff,
                    title: 'Positive Declarations',
                    titleColor: _selectedIndex == 11 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 11 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.question_answer,
                    onTap: () => _onItemTapped(12),
                    iconColor: _selectedIndex == 12 ? 0xFF000000 : 0xFFffffff,
                    title: 'FAQs Category',
                    titleColor: _selectedIndex == 12 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 12 ? 0xFFffffff : 0xFF000000,
                  ),
                  Gaps.hGap20,
                  DashboardFields(
                    icon: Icons.question_answer,
                    onTap: () => _onItemTapped(13),
                    iconColor: _selectedIndex == 13 ? 0xFF000000 : 0xFFffffff,
                    title: 'FAQs',
                    titleColor: _selectedIndex == 13 ? 0xFF000000 : 0xFFffffff,
                    containerColor:
                        _selectedIndex == 13 ? 0xFFffffff : 0xFF000000,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFffffff),
              child: _screens.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
