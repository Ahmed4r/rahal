import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahal/screens/home/home_page.dart';
import 'package:rahal/screens/settings/setting__page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarPage> {
  final List<_NavItem> items = [
    _NavItem(
      icon: CupertinoIcons.home,
      label: 'Home',
    ),
    // _NavItem(
    //   icon: FluentIcons.map_24_regular,
    //   activeIcon: FluentIcons.map_24_filled,
    //   label: 'Tracks',
    // ),
    // _NavItem(
    //   icon: FluentIcons.briefcase_24_regular,
    //   activeIcon: FluentIcons.briefcase_24_filled,
    //   label: 'Trips',
    // ),
    // _NavItem(
    //   icon: FluentIcons.grid_dots_24_regular,
    //   activeIcon: FluentIcons.grid_dots_24_filled,
    //   label: 'More',
    // ),
    _NavItem(
      icon: CupertinoIcons.settings,
      label: 'Settings',
    ),
  ];

  final List<Widget> _pages = [
    HomePage(),
    // TracksPage(),
    // TripsPage(),
    // MorePage(),
    SettingPage(),
  ];

  int _selectedNavIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        showSelectedLabels: true,
        useLegacyColorScheme: false,
        currentIndex: _selectedNavIndex,
        onTap: _onNavItemTapped,
        items: items.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
