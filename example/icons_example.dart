import 'package:category_navigator/category_navigator.dart';
import 'package:flutter/material.dart';

class IconsExample extends StatefulWidget {
  const IconsExample({Key? key}) : super(key: key);

  @override
  State<IconsExample> createState() => _IconsExampleState();
}

class _IconsExampleState extends State<IconsExample> {
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

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return CategoryNavigator(
      labels: itemsList,
      builder: (context, index, selected) => Icon(
        icons[index],
        color: (selected == index) ? Colors.black : Colors.white,
      ),
      navigatorController: NavigatorController(),
      scrollController: ScrollController(),
      onChange: (activeItem) => setState(() => selected = activeItem),
    );
  }
}
