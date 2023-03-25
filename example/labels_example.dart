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
    return CategoryNavigator(
      labels: itemsList,
      navigatorController: NavigatorController(),
      scrollController: ScrollController(),
      onChange: (activeItem) {},
      builder: (context, index, selected) => Container(),
    );
  }
}
