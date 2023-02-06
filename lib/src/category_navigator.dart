import 'package:category_navigator/src/navigation_menu.dart';
import 'package:flutter/material.dart';

class CategoryNavigator extends StatefulWidget {
  const CategoryNavigator({
    super.key,
    required this.navigationMenu,
  });

  final NavigationMenu navigationMenu;

  @override
  State<CategoryNavigator> createState() => _CategoryNavigatorState();
}

class _CategoryNavigatorState extends State<CategoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return widget.navigationMenu;
  }
}
