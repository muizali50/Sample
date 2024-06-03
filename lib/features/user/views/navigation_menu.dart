import 'package:flutter/material.dart';
import 'package:mind_labify/features/user/views/blog.dart';
import 'package:mind_labify/features/user/views/sub_features/breathwork/views/breathwork.dart';
import 'package:mind_labify/features/user/views/sub_features/home/views/home_screen.dart';
import 'package:mind_labify/features/user/views/sub_features/meditation/views/meditation.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    Breathwork(),
    Meditation(),
    Blog(),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 85,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.11),
              offset: const Offset(0, 4),
              blurRadius: 11,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: ImageIcon(
                AssetImage(
                  'assets/icons/s_home.png',
                ),
              ),
              icon: ImageIcon(
                AssetImage(
                  'assets/icons/home.png',
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/icons/breathwork.png',
                ),
              ),
              label: 'Breathwork',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/icons/meditation.png',
                ),
              ),
              label: 'Meditation',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/icons/blog.png',
                ),
              ),
              label: 'Blogs',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: const Color(0xFFD9D8D8),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          iconSize: 28,
        ),
      ),
    );
  }
}
