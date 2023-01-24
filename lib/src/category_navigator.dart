import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:category_navigator/src/category_navigator_item.dart';
import 'package:category_navigator/src/navigator_controller.dart';

class CategoryNavigator extends StatefulWidget {
  const CategoryNavigator({
    super.key,
    required this.items,
    required this.navigatorController,
    required this.scrollController,
    this.expand = true,
    this.icons,
    this.defaultActiveItem = 0,
    this.navigatorBackgroundColor = Colors.black,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
    this.axis = Axis.horizontal,
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    this.navigatorElevation = 5,
    this.highlightBackgroundColor = Colors.white,
    this.unselectedBackgroundColor,
    this.shadow = const [BoxShadow(color: Colors.black)],
    this.itemElevation = 0,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.itemMargin = const EdgeInsets.symmetric(horizontal: 8),
    this.highlightTextStyle = const TextStyle(color: Colors.black),
    this.unselectedTextStyle = const TextStyle(color: Colors.white),
  });

  final List<String> items;
  final List<dynamic>? icons;
  final int defaultActiveItem;
  final bool expand;

  final Color navigatorBackgroundColor;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Axis axis;
  final ShapeBorder shape;
  final double navigatorElevation;

  final Color highlightBackgroundColor;
  final Color? unselectedBackgroundColor;
  final TextStyle highlightTextStyle;
  final TextStyle unselectedTextStyle;
  final List<BoxShadow> shadow;
  final double itemElevation;
  final BorderRadius borderRadius;
  final EdgeInsets itemPadding;
  final EdgeInsets itemMargin;

  final NavigatorController navigatorController;
  final ScrollController scrollController;

  @override
  State<CategoryNavigator> createState() => _HorizontalNavigationState();
}

class _HorizontalNavigationState extends State<CategoryNavigator> {
  List<Widget> itemWidgets = [];
  List<GlobalObjectKey> keys = [];

  @override
  void initState() {
    _generateWidgetList(widget.items);
    super.initState();
  }

  _generateWidgetList(List<String> items) {
    items.forEachIndexed((index, item) {
      GlobalObjectKey key = GlobalObjectKey(index);
      keys.add(key);
      itemWidgets.add(NavigatorItem(
        key: key,
        label: item,
        controller: widget.navigatorController,
        highlightBackgroundColor: widget.highlightBackgroundColor,
        unselectedBackgroundColor: (widget.unselectedBackgroundColor == null)
            ? widget.navigatorBackgroundColor
            : widget.unselectedBackgroundColor!,
        shadow: widget.shadow,
        padding: widget.itemPadding,
        margin: widget.itemMargin,
        unselectedTextStyle: widget.unselectedTextStyle,
        highlightTextStyle: widget.highlightTextStyle,
        elevation: widget.itemElevation,
        iconData: (widget.icons == null) ? null : widget.icons![index],
      ));
    });
    widget.navigatorController
        .updateActiveItem(keys.elementAt(widget.defaultActiveItem));
    double x = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (int i = 0; i < widget.defaultActiveItem; i++) {
        x += (keys.elementAt(i)).currentContext!.size!.width;
      }
      widget.scrollController.animateTo(x,
          duration: Duration(milliseconds: widget.defaultActiveItem * 100),
          curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget nav = Card(
      shape: widget.shape,
      color: widget.navigatorBackgroundColor,
      margin: widget.margin,
      elevation: widget.navigatorElevation,
      clipBehavior: Clip.hardEdge,
      child: Center(
        heightFactor: 1,
        widthFactor: 1,
        child: SingleChildScrollView(
          scrollDirection: widget.axis,
          controller: widget.scrollController,
          child: Padding(
            padding: widget.padding,
            child: Flex(direction: widget.axis, children: itemWidgets),
          ),
        ),
      ),
    );
    return (widget.expand) ? fillMainAxis(nav) : nav;
  }

  fillMainAxis(nav) {
    return (widget.axis == Axis.horizontal)
        ? SizedBox(width: double.infinity, child: nav)
        : SizedBox(height: double.infinity, child: nav);
  }

  @override
  void dispose() {
    widget.navigatorController.dispose();
    widget.scrollController.dispose();
    super.dispose();
  }
}
