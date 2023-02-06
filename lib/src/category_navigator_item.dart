import 'package:flutter/material.dart';
import 'package:category_navigator/src/navigator_controller.dart';

class NavigatorItem extends StatefulWidget {
  const NavigatorItem({
    super.key,
    this.label,
    this.iconData,
    required this.controller,
    this.highlightBackgroundColor = Colors.white,
    this.unselectedBackgroundColor = Colors.black,
    this.highlightTextStyle = const TextStyle(color: Colors.black),
    this.unselectedTextStyle = const TextStyle(color: Colors.white),
    this.shadow = const [BoxShadow(color: Colors.black)],
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.margin = const EdgeInsets.symmetric(horizontal: 8),
    this.elevation = 0,
  });

  /// [label] and [iconData] both cannot be null

  final String? label;
  final IconData? iconData;
  final NavigatorController controller;
  final Color highlightBackgroundColor;
  final Color unselectedBackgroundColor;
  final TextStyle highlightTextStyle;
  final TextStyle unselectedTextStyle;
  final List<BoxShadow> shadow;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double elevation;

  @override
  State<NavigatorItem> createState() => _NavigatorItemState();
}

class _NavigatorItemState extends State<NavigatorItem>
    with TickerProviderStateMixin {
  late Color backgroundColor = widget.unselectedBackgroundColor;
  late Color textColor = widget.unselectedTextStyle.color ?? Colors.white;
  late List<BoxShadow> shadow = widget.shadow;
  double elevation = 0;
  late TextStyle textStyle = widget.unselectedTextStyle;
  late Widget child;
  double widgetWidth = 0;

  @override
  void initState() {
    super.initState();
    assert(widget.key is GlobalObjectKey);
    widget.controller.addListener(toggleState);
  }

  /// updates the state of the item
  toggleState() {
    setState(() {
      if (widget.controller.isItemActive(widget.key!)) {
        backgroundColor = widget.highlightBackgroundColor;
        shadow = widget.shadow;
        elevation = widget.elevation;
        textStyle = widget.highlightTextStyle;
        textColor = widget.highlightTextStyle.color!;
        child = Text(
          widget.label ?? '',
          style: textStyle,
        );
      } else {
        backgroundColor = widget.unselectedBackgroundColor;
        shadow = [const BoxShadow(color: Colors.transparent)];
        elevation = 0;
        textStyle = widget.unselectedTextStyle;
        textColor = widget.unselectedTextStyle.color!;
        child = const SizedBox(
          height: 0,
          width: 0,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    toggleState();
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () =>
            widget.controller.updateActiveItem(widget.key as GlobalObjectKey),
        child: Padding(
            padding: widget.margin,
            child: Material(
                elevation: elevation,
                borderRadius: widget.borderRadius,
                color: backgroundColor,
                child: AnimatedContainer(
                    padding: widget.padding,
                    curve: Curves.decelerate,
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: shadow),
                    child: _buildChild(child)))));
  }

  /// Generates child based on weather icon and label are available or not.
  _buildChild(Widget child) => (widget.iconData == null)
      ? Text(
          widget.label!,
          style: textStyle,
        )
      : (widget.label != null)
          ? Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                widget.iconData,
                color: textColor,
              ),
              const SizedBox(width: 5),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200), child: child),
              )
            ])
          : Icon(widget.iconData, color: textColor);

  @override
  void dispose() {
    widget.controller.removeListener(toggleState);
    super.dispose();
  }
}
