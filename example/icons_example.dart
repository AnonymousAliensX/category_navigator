import 'package:category_navigator/category_navigator.dart';
import 'package:flutter/material.dart';

class IconsExample extends StatelessWidget {
  const IconsExample({Key? key}) : super(key: key);

  final List<String> itemsList = const [
    'All',
    'Android',
    'Animation',
    'Flutter',
    'Text',
    'iOS',
    'Web',
    'Windows'
  ];

  /// you can pass in null instead of an icon, in case you only want a label in any category
  final List<dynamic> icons = const [
    null,
    Icons.android,
    Icons.animation,
    Icons.flutter_dash,
    Icons.text_fields,
    Icons.apple,
    Icons.web,
    Icons.laptop_windows_sharp
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: CategoryNavigator(
              labels: itemsList,
              icons: icons,
              navigatorController: NavigatorController(),
              scrollController: ScrollController(),
            ),
          ),
        ),
      ),
    );
  }
}
