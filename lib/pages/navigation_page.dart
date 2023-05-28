import 'package:flutter/material.dart';

import '../config/colors.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'profile_page.dart';

class NavigationPage extends StatefulWidget {
  static const routeName = '/navigation';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<NavigationPage> {
  int _currentIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    HomePage()
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (_currentIndex == 2) {
      _showLogoutConfirmationDialog(context);
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            },
            child: Text('Logout'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primary,
        selectedItemColor: text,
        unselectedItemColor: text.withOpacity(0.5),
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}