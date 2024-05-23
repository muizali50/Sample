import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_labify/features/admin/views/all_stressors.dart';
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
                  containerColor: _selectedIndex == 0 ? 0xFFffffff : 0xFF000000,
                ),
                Gaps.hGap20,
                DashboardFields(
                  icon: CupertinoIcons.doc_append,
                  onTap: () => _onItemTapped(1),
                  iconColor: _selectedIndex == 1 ? 0xFF000000 : 0xFFffffff,
                  title: 'Stressors',
                  titleColor: _selectedIndex == 1 ? 0xFF000000 : 0xFFffffff,
                  containerColor: _selectedIndex == 1 ? 0xFFffffff : 0xFF000000,
                ),
              ],
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
