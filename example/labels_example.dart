import 'package:category_navigator/category_navigator.dart';
import 'package:flutter/material.dart';

class LabelOnlyExample extends StatelessWidget {
  const LabelOnlyExample({Key? key}) : super(key: key);

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
                  labels: itemsList,
                  navigatorController: NavigatorController(),
                  scrollController: ScrollController(),
                  onChange: (activeItem) {},
                ))));
  }
}
