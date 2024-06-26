import 'package:flutter/material.dart';

class BottomBarItem {
  final String label;
  final Icon icon;
  final Icon iconOutline;
  final Widget screen;
  final GlobalKey? key;

  BottomBarItem({
    required this.label,
    required this.icon,
    required this.iconOutline,
    required this.screen,
    this.key,
  });
}

class NavbarItem {
  final String title;
  final bool showBackgroundColour;

  NavbarItem({
    required this.title,
    required this.showBackgroundColour,
  });
}