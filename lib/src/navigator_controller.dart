import 'package:flutter/material.dart';

class NavigatorController extends ChangeNotifier {
  NavigatorController();

  /// Stores index of item active in the navigation menu.
  int activeItemIndex = 0;

  /// This method is used to update the active item in the navigation menu and
  /// executes the registered callbacks to update states of items widgets.
  updateActiveItem(GlobalObjectKey key) {
    ChangeNotifier.debugAssertNotDisposed(this);
    activeItemIndex = key.value as int;
    notifyListeners();
  }

  /// This method is used by widgets to check current state of the item widget
  /// and it should update current state or not.
  bool isItemActive(Key key) =>
      activeItemIndex == (key as GlobalObjectKey).value as int;
}
