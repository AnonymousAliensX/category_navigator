import 'package:category_navigator/category_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test with base implementation', () {
    final calculator = CategoryNavigator(
        labels: const ['aaa', 'fff'],
        navigatorController: NavigatorController(),
        scrollController: ScrollController());
  });
}
