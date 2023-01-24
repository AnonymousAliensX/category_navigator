import 'package:category_navigator/category_navigator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
                child: CategoryNavigator(
                  items: itemsList,
                  navigatorController: NavigatorController(),
                  scrollController: ScrollController(),
                ))));
  }
}

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
              items: itemsList,
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
