// bottom_navigation.dart
import 'package:ayiolo_safari_advisor/screens/home_page.dart';
import 'package:ayiolo_safari_advisor/screens/locations.dart';
import 'package:ayiolo_safari_advisor/screens/profile.dart';
import 'package:ayiolo_safari_advisor/screens/safari_advisor.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
   int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const LocationNavItem(),
    const SafariAdvisor(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
