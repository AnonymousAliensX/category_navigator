import 'package:flutter/material.dart';

class NavigatorController extends ChangeNotifier {
  /// This controller is used for maintaining state if only the active item is
  /// expected to be expanded, this is default controller used for horizontal
  /// [CategoryNavigator].
  NavigatorController();

  /// Use this constructor to expand and collapse all navigation items at one
  /// time. This is used for vertical [CategoryNavigator].
  NavigatorController.expand() : _expanded = false;

  /// Stores index of item active in the navigation menu.
  int activeItemIndex = 0;

  /// Whether all items will be in collapsed state or not.
  bool? _expanded;

  /// This method is used to update the active item in the navigation menu and
  /// executes the registered callbacks to update states of items widgets.
  updateActiveItem(Key key) {
    ChangeNotifier.debugAssertNotDisposed(this);
    String keyValue = (key as GlobalObjectKey).value as String;
    activeItemIndex = int.parse(keyValue.substring(keyValue.length - 1)[0]);
    notifyListeners();
  }

  /// This method is used by widgets to check current state of the item widget
  /// and it should update current state or not.
  bool isItemActive(Key key) {
    String keyValue = (key as GlobalObjectKey).value as String;
    return activeItemIndex == int.parse(keyValue.substring(keyValue.length - 1)[0]);
  }

  toggleExpanded() {
    assert(_expanded != null);
    _expanded = !_expanded!;
    notifyListeners();
  }

  bool isItemExpanded(Key key) => _expanded ?? (isItemActive(key));
}
