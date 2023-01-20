import 'package:flutter/material.dart';
import 'package:category_navigator/src/navigator_controller.dart';

class NavigatorItem extends StatefulWidget {
  const NavigatorItem({
    super.key,
    required this.text,
    required this.controller,
    required this.highlightBackgroundColor,
    required this.unselectedBackgroundColor,
    required this.shadow,
    required this.padding,
    required this.margin,
    required this.elevation,
    required this.highlightTextStyle,
    required this.unselectedTextStyle,
  });

  final String text;
  final Color highlightBackgroundColor;
  final Color unselectedBackgroundColor;
  final TextStyle highlightTextStyle;
  final TextStyle unselectedTextStyle;
  final List<BoxShadow> shadow;
  final NavigatorController controller;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double elevation;

  @override
  State<NavigatorItem> createState() => _NavigatorItemState();
}

class _NavigatorItemState extends State<NavigatorItem> {
  late Color backgroundColor;
  late Color textColor;
  late List<BoxShadow> shadow;
  BoxDecoration decoration = const BoxDecoration();
  double elevation = 0;
  late TextStyle textStyle;

  @override
  void initState() {
    super.initState();
    assert(widget.key is GlobalObjectKey);
    widget.controller.addListener(toggleState);
    toggleState();
  }

  toggleState() {
    setState(() {
      if (widget.controller.isItemActive(widget.key!)) {
        backgroundColor = widget.highlightBackgroundColor;
        shadow = widget.shadow;
        elevation = widget.elevation;
        textStyle = widget.highlightTextStyle;
      } else {
        backgroundColor = widget.unselectedBackgroundColor;
        shadow = [const BoxShadow(color: Colors.transparent)];
        decoration = const BoxDecoration();
        elevation = 0;
        textStyle = widget.unselectedTextStyle;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () =>
          widget.controller.updateActiveItem(widget.key as GlobalObjectKey),
      child: Padding(
        padding: widget.margin,
        child: Material(
          elevation: elevation,
          borderRadius: BorderRadius.circular(10),
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
            child: Text(
              widget.text,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(toggleState);
    super.dispose();
  }
}
