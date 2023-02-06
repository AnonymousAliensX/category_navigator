import 'package:category_navigator/category_navigator.dart';
import 'package:flutter/material.dart';

class LabelOnlyNavigationMenu extends StatelessWidget {
  const LabelOnlyNavigationMenu({Key? key}) : super(key: key);

  final List<String> itemsList = const [
    'All',
    'Android',
    'ML',
    'Python',
    'Flutter',
    'Text',
    'iOS',
    'Web',
    'Windows'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NavigationMenu(
                  labels: itemsList,
                  navigatorController: NavigatorController(),
                  scrollController: ScrollController(),
                )))
    );
  }
}
