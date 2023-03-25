import 'package:flutter/material.dart';
import 'package:category_navigator/src/category_navigator_item.dart';
import 'package:category_navigator/src/navigator_controller.dart';

class CategoryNavigator extends StatefulWidget {
  const CategoryNavigator({
    super.key,
    this.labels,
    required this.onChange,
    this.builder,
    this.navigatorController,
    this.scrollController,
    this.expand = true,
    this.defaultActiveItem = 0,
    this.navigatorBackgroundColor = Colors.black,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
    // this.axis = Axis.horizontal,
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    this.navigatorElevation = 5,
    this.highlightBackgroundColor = Colors.white,
    this.unselectedBackgroundColor = Colors.black,
    this.shadow = const [BoxShadow(color: Colors.black)],
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.itemElevation = 0,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.itemMargin = const EdgeInsets.symmetric(horizontal: 8),
    this.highlightTextStyle = const TextStyle(color: Colors.black),
    this.unselectedTextStyle = const TextStyle(color: Colors.white),
  });

  /// This bool variable tells the navigation bar whether to take the full space
  /// available in the [axis] of the menu i.e. if the [axis] parameter is
  /// [Axis.horizontal] and this parameter is true, the navigation bar will
  /// completely expand in horizontal direction. Value defaults to true.
  final bool expand;

  /// The labels used for navigation items, can be null
  final List<String>? labels;

  /// The item that will be set active at first, defaults to 0
  final int defaultActiveItem;

  /// Background color for Navigation menu
  final Color navigatorBackgroundColor;

  /// The margin around the menu
  final EdgeInsets margin;

  /// The padding around the menu
  final EdgeInsets padding;

  /// The orientation/direction of the navigation menu
  final Axis axis = Axis.horizontal;

  /// The [ShapeBorder] property that can be used to customize background shape
  /// of the navigation menu
  final ShapeBorder shape;

  /// The elevation of the navigation menu
  final double navigatorElevation;

  final void Function(int) onChange;
  final Widget? Function(BuildContext context, int index, int selected)?
      builder;

  /// Additional parameters for customization of the [NavigatorItem].
  final Color highlightBackgroundColor;
  final Color unselectedBackgroundColor;
  final TextStyle highlightTextStyle;
  final TextStyle unselectedTextStyle;
  final List<BoxShadow> shadow;
  final double itemElevation;
  final BorderRadius borderRadius;
  final EdgeInsets itemPadding;
  final EdgeInsets itemMargin;

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
  int selected = 0;
  late ScrollController scrollController;
  late NavigatorController navigatorController;

  @override
  void initState() {
    if (widget.labels != null) {
      length = widget.labels!.length;
    }
    selected = widget.defaultActiveItem;
    navigatorController = widget.navigatorController ?? NavigatorController();
    scrollController = widget.scrollController ?? ScrollController();
    _generateKeys();
    _scrollWidgetList();
    super.initState();
  }

  _generateKeys() {
    keys = List.generate(
        length, (index) => GlobalObjectKey('navigator_item$index'));
  }

  /// This method is used to scroll to item if it is outside the viewport
  ///
  /// This method registers a callback which is called during the frame, so the widgets
  /// are already built at this point and we can retrieve widget size using the [GlobalObjectKey]
  /// and accessing [BuildContext.size] property to calculate the distance the items
  /// list has to scroll to get to the active item. Later, it uses the [CategoryNavigator.scrollController]
  /// and scrolls the list to the item at [CategoryNavigator.defaultActiveItem] using
  /// [ScrollController.animateTo] method.
  _scrollWidgetList() {
    navigatorController.addListener(() {
      setState(() => selected = navigatorController.activeItemIndex);
      widget.onChange(navigatorController.activeItemIndex);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigatorController
          .updateActiveItem(keys.elementAt(widget.defaultActiveItem));

    });
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
                  child: _getFlex(
                      child: Flex(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          direction: widget.axis,
                          children: List.generate(
                              length,
                              (index) => InkWell(
                                  key: keys[index],
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    navigatorController
                                        .updateActiveItem(keys[index]);
                                  },
                                  child: Padding(
                                      padding: widget.itemMargin,
                                      child: Material(
                                          elevation: (selected == index)
                                              ? widget.itemElevation
                                              : 0,
                                          borderRadius: widget.borderRadius,
                                          color: (selected == index)
                                              ? widget.highlightBackgroundColor
                                              : widget
                                                  .unselectedBackgroundColor,
                                          child: AnimatedContainer(
                                              padding: widget.itemPadding,
                                              curve: Curves.decelerate,
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              decoration: BoxDecoration(
                                                  color: (selected == index)
                                                      ? widget
                                                          .highlightBackgroundColor
                                                      : widget
                                                          .unselectedBackgroundColor,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      widget.borderRadius,
                                                  boxShadow: (selected == index)
                                                      ? widget.shadow
                                                      : [
                                                          const BoxShadow(
                                                              color: Colors
                                                                  .transparent)
                                                        ]),
                                              child: _buildItem(
                                                  selected == index,
                                                  index)))))))))),
        ));
    return (widget.expand) ? _fillMainAxis(child: nav) : nav;
  }

  _buildItem(bool selected, int index) {
    Widget? child;
    if (widget.builder != null) {
      child = widget.builder!(context, index, this.selected);
    }
    return (widget.builder == null || child == null)
        ? Text(widget.labels![index],
            style: selected
                ? widget.highlightTextStyle
                : widget.unselectedTextStyle)
        : (widget.labels != null)
            ? Row(mainAxisSize: MainAxisSize.min, children: [
                child ?? Container(),
                const SizedBox(width: 5),
                AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: (selected)
                          ? Text(widget.labels![index],
                              style: selected
                                  ? widget.highlightTextStyle
                                  : widget.unselectedTextStyle)
                          : const SizedBox(height: 0, width: 0),
                    ))
              ])
            : child;
  }

  // : Icon(widget.icons![index],
  //     color: selected
  //         ? widget.highlightTextStyle.color
  //         : widget.unselectedTextStyle.color,
  //     size: widget.iconSize);

  ///Expands the navigation menu to fill complete space
  ///
  /// This method wraps the child in a [SizedBox] with one dimension set to
  /// [double.infinity] to ensure the menu takes up whole space in given [axis]
  /// direction. If [CategoryNavigator.expand] is true, this method is called
  /// otherwise the navigation menu only takes up just enough space for the items.
  SizedBox _fillMainAxis({required Card child}) {
    return (widget.axis == Axis.horizontal)
        ? SizedBox(width: double.infinity, child: child)
        : SizedBox(height: double.infinity, child: child);
  }

  /// This method wraps the [Flex] in an [IntrinsicHeight] widget if the [axis]
  /// is [Axis.horizontal] to ensure no height differences in children of the menu.
  Widget _getFlex({required Flex child}) {
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
