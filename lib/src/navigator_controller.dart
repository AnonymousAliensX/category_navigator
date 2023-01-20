import 'package:flutter/material.dart';

class NavigatorController extends ChangeNotifier {
  NavigatorController();

  late int activeItemIndex;

  updateActiveItem(GlobalObjectKey key) {
    ChangeNotifier.debugAssertNotDisposed(this);
    activeItemIndex = key.value as int;
    notifyListeners();
  }

  bool isItemActive(Key key) =>
      activeItemIndex == (key as GlobalObjectKey).value as int;
}
