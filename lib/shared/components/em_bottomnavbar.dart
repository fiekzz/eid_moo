import 'package:eid_moo/features/general/account_screen.dart';
import 'package:eid_moo/features/general/home_screen.dart';
import 'package:eid_moo/shared/components/em_baritem.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EMBottomNavbar extends StatefulWidget {
  const EMBottomNavbar({super.key});

  @override
  State<EMBottomNavbar> createState() => _EMBottomNavbarState();
}

class _EMBottomNavbarState extends State<EMBottomNavbar> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomBarItem> _bottomBarItems = [
    BottomBarItem(
      label: 'Home',
      icon: const Icon(
        Ionicons.home,
        color: EidMooTheme.primaryVariant,
      ),
      iconOutline: const Icon(
        Ionicons.home_outline,
        color: Colors.grey,
      ),
      screen: const HomeScreen(),
    ),
    BottomBarItem(
      label: 'Account',
      icon: const Icon(
        Ionicons.person,
        color: EidMooTheme.primaryVariant,
      ),
      iconOutline: const Icon(
        Ionicons.person_outline,
        color: Colors.grey,
      ),
      screen: const AccountScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomBarItems[_selectedIndex].screen,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: EidMooTheme.primaryVariant,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: _bottomBarItems
                .map(
                  (item) => BottomNavigationBarItem(
                    activeIcon: item.icon,
                    icon: item.iconOutline,
                    label: item.label,
                  ),
                )
                .toList(),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: EidMooTheme.primaryVariant,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 10,
            selectedFontSize: 10,
          ),
        ),
      ),
    );
  }
}
