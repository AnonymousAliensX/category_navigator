import 'package:flutter/material.dart';
import 'package:category_navigator/src/category_navigator_item.dart';
import 'package:category_navigator/src/navigator_controller.dart';

class CategoryNavigator extends StatefulWidget {
  const CategoryNavigator({
    super.key,
    this.labels,
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
  })  : assert(icons != null || labels != null),
        assert((icons != null && labels != null)
            ? (icons.length == labels.length)
            : true);

  final List<String>? labels;
  final List<dynamic>? icons;
  final int defaultActiveItem;

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
  State<CategoryNavigator> createState() => _CategoryNavigatorState();
}

class _CategoryNavigatorState extends State<CategoryNavigator> {
  List<Widget> itemWidgets = [];
  List<GlobalObjectKey> keys = [];
  int length = 0;

  @override
  void initState() {
    if (widget.labels != null) {
      length = widget.labels!.length;
    } else {
      length = widget.icons!.length;
    }
    _generateWidgetList();
    super.initState();
  }

  _generateWidgetList() {
    for (int index = 0; index < length; index++) {
      GlobalObjectKey key = GlobalObjectKey(index);
      keys.add(key);
      itemWidgets.add(_generateNavigationItem(index));
    }
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

  _generateNavigationItem(int index) {
    Widget item = NavigatorItem(
      key: keys[index],
      label: (widget.labels == null) ? null : widget.labels![index],
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
    );
    if (widget.icons != null && widget.icons![index] == null) {
      item = FittedBox(
        fit: BoxFit.contain,
        child: item,
      );
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    Card nav = Card(
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
              child: getFlex(
                  child: Flex(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                direction: widget.axis,
                children: itemWidgets,
              ))),
        ),
      ),
    );
    return (widget.expand) ? fillMainAxis(child: nav) : nav;
  }

  Widget getFlex({required Flex child}) {
    return (widget.axis == Axis.horizontal)
        ? IntrinsicHeight(child: child)
        : child;
  }

  SizedBox fillMainAxis({required Card child}) {
    return (widget.axis == Axis.horizontal)
        ? SizedBox(width: double.infinity, child: child)
        : SizedBox(height: double.infinity, child: child);
  }

  @override
  void dispose() {
    widget.navigatorController.dispose();
    widget.scrollController.dispose();
    super.dispose();
  }
}
