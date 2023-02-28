import 'package:flutter/material.dart';
import 'package:category_navigator/src/category_navigator_item.dart';
import 'package:category_navigator/src/navigator_controller.dart';

class CategoryNavigator extends StatefulWidget {
  const CategoryNavigator({
    super.key,
    this.labels,
    this.icons,
    this.navigatorController,
    this.scrollController,
    this.expand = true,
    this.defaultActiveItem = 0,
    this.navigatorBackgroundColor = Colors.black,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
    this.axis = Axis.horizontal,
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    this.navigatorElevation = 5,
    this.highlightBackgroundColor,
    this.unselectedBackgroundColor,
    this.shadow,
    this.borderRadius,
    this.itemElevation,
    this.itemPadding,
    this.itemMargin,
    this.highlightTextStyle,
    this.unselectedTextStyle,
  })  : assert(icons != null || labels != null),
        assert((icons != null && labels != null)
            ? (icons.length == labels.length)
            : true);

  /// This bool variable tells the navigation bar whether to take the full space
  /// available in the [axis] of the menu i.e. if the [axis] parameter is
  /// [Axis.horizontal] and this parameter is true, the navigation bar will
  /// completely expand in horizontal direction. Value defaults to true.
  final bool expand;

  /// The labels used for navigation items, can be null
  final List<String>? labels;

  /// The icons used for navigation items, can be null
  final List<dynamic>? icons;

  /// The item that will be set active at first, defaults to 0
  final int defaultActiveItem;

  /// Background color for Navigation menu
  final Color navigatorBackgroundColor;

  /// The margin around the menu
  final EdgeInsets margin;

  /// The padding around the menu
  final EdgeInsets padding;

  /// The orientation/direction of the navigation menu
  final Axis axis;

  /// The [ShapeBorder] property that can be used to customize background shape
  /// of the navigation menu
  final ShapeBorder shape;

  /// The elevation of the navigation menu
  final double navigatorElevation;

  /// Additional parameters for customization of the [NavigatorItem].

  final Color? highlightBackgroundColor;
  final Color? unselectedBackgroundColor;
  final TextStyle? highlightTextStyle;
  final TextStyle? unselectedTextStyle;
  final List<BoxShadow>? shadow;
  final double? itemElevation;
  final BorderRadius? borderRadius;
  final EdgeInsets? itemPadding;
  final EdgeInsets? itemMargin;

  /// The controller object to handle active items
  final NavigatorController? navigatorController;

  /// The controller to handle scrolling of the menu
  final ScrollController? scrollController;

  @override
  State<CategoryNavigator> createState() => _CategoryNavigatorState();
}

class _CategoryNavigatorState extends State<CategoryNavigator> {
  List<Widget> itemWidgets = [];
  List<GlobalObjectKey> keys = [];
  int length = 0;
  late ScrollController scrollController;
  late NavigatorController navigatorController;

  @override
  void initState() {
    if (widget.labels != null) {
      length = widget.labels!.length;
    } else {
      length = widget.icons!.length;
    }
    navigatorController = widget.navigatorController ??
        ((widget.axis == Axis.horizontal)
            ? NavigatorController()
            : NavigatorController.expand());
    scrollController = widget.scrollController ?? ScrollController();
    _generateWidgetList();
    super.initState();
  }

  /// Generates all items for navigation menu
  ///
  /// This method adds all the navigation items in the [itemWidgets] list
  /// generated using [_generateNavigationItem] method and after the creation
  /// of all the widgets, it updates the [NavigatorController] for [CategoryNavigator.defaultActiveItem].
  /// Even though the item is being set as active, it will be not be visible to
  /// the user if [CategoryNavigator.defaultActiveItem] is set to a larger index. For that, [WidgetsBinding.addPostFrameCallback]
  /// is used to register a callback which is called during the frame, so the widgets
  /// are built at this point and we can retrieve widget size using the [GlobalObjectKey]
  /// and accessing [BuildContext.size] property to calculate the distance the items
  /// list has to scroll to get to the active item. Later, it uses the [CategoryNavigator.scrollController]
  /// and scrolls the list to the item at [CategoryNavigator.defaultActiveItem] using
  /// [ScrollController.animateTo] method.
  _generateWidgetList() {
    for (int index = 0; index < length; index++) {
      GlobalObjectKey key = GlobalObjectKey(index);
      keys.add(key);
      itemWidgets.add(_generateNavigationItem(index));
    }
    navigatorController
        .updateActiveItem(keys.elementAt(widget.defaultActiveItem));

    if (widget.axis == Axis.vertical) {
      itemWidgets.add(
        InkWell(
          onTap: navigatorController.toggleExpanded,
          child: const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.white,
          ),
        )
      );
    }

    double scrollDistance = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double maxHeight = 0;
      for (int i = 0; i < widget.defaultActiveItem; i++) {
        (widget.axis == Axis.horizontal)
            ? scrollDistance += (keys.elementAt(i)).currentContext!.size!.width
            : scrollDistance +=
                (keys.elementAt(i)).currentContext!.size!.height;
        if (widget.axis == Axis.vertical) {
          var x = (keys.elementAt(i).currentContext!.size!.height);
          maxHeight = (x > maxHeight) ? x : maxHeight;
          // todo: use this to adjust widget size in vertical navigation
        }
        // todo: fix [ScrollController] issue
      // if (x > MediaQuery.of(context).size.width) {
      //   scrollController.animateTo(x,
      //     duration: Duration(milliseconds: widget.defaultActiveItem * 100),
      //     curve: Curves.linear);
      // }
      }
    });
  }

  /// Generate navigation item for the data
  ///
  /// This method generates a [NavigatorItem] widget for each label or icon and
  /// wraps it around a FittedBox if icon is null when using both labels and icons.
  _generateNavigationItem(int index) {
    Widget item = NavigatorItem(
      key: keys[index],
      label: (widget.labels == null) ? null : widget.labels![index],
      controller: navigatorController,
      highlightBackgroundColor: widget.highlightBackgroundColor ?? Colors.white,
      unselectedBackgroundColor:
          widget.unselectedBackgroundColor ?? Colors.black,
      highlightTextStyle:
          widget.highlightTextStyle ?? const TextStyle(color: Colors.black),
      unselectedTextStyle:
          widget.unselectedTextStyle ?? const TextStyle(color: Colors.white),
      shadow: widget.shadow ?? const [BoxShadow(color: Colors.black)],
      borderRadius:
          widget.borderRadius ?? const BorderRadius.all(Radius.circular(10)),
      padding: widget.itemPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: widget.itemMargin ??
          ((widget.axis == Axis.horizontal)
              ? const EdgeInsets.symmetric(horizontal: 8)
              : const EdgeInsets.symmetric(vertical: 8)),
      elevation: widget.itemElevation ?? 0,
      iconData: (widget.icons == null) ? null : widget.icons![index],
    );
    if (widget.icons != null &&
        widget.icons![index] == null &&
        widget.axis == Axis.horizontal) {
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
          controller: scrollController,
          child: Padding(
              padding: widget.padding,
              child: getFlex(
                  child: Flex(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                direction: widget.axis,
                children: itemWidgets
              ))),
        ),
      ),
    );
    return (widget.expand) ? fillMainAxis(child: nav) : nav;
  }

  ///Expands the navigation menu to fill complete space
  ///
  /// This method wraps the child in a [SizedBox] with one dimension set to
  /// [double.infinity] to ensure the menu takes up whole space in given [axis]
  /// direction. If [CategoryNavigator.expand] is true, this method is called
  /// otherwise the navigation menu only takes up just enough space for the items.
  SizedBox fillMainAxis({required Card child}) {
    return (widget.axis == Axis.horizontal)
        ? SizedBox(width: double.infinity, child: child)
        : SizedBox(height: double.infinity, child: child);
  }

  /// This method wraps the [Flex] in an [IntrinsicHeight] widget if the [axis]
  /// is [Axis.horizontal] to ensure no height differences in children of the menu.
  Widget getFlex({required Flex child}) {
    return (widget.axis == Axis.horizontal)
        ? IntrinsicHeight(child: child)
        : IntrinsicWidth(child: child);
  }

  @override
  void dispose() {
    navigatorController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
