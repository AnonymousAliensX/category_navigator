# Category Navigator

[![Anonymous Aliens](https://img.shields.io/badge/By-Anonymous%20Aliens-red)](https://anonymousaliens.app/)
[![Made with Flutter](https://img.shields.io/badge/-Flutter-blue?logo=flutter)](https://flutter.dev/)
[![pub version](https://img.shields.io/pub/v/category_navigator?color=orange)](https://pub.dev/packages/category_navigator) 
[![pub package](https://img.shields.io/github/languages/code-size/AnonymousAliensX/category_navigator?color=success)](https://pub.dev/packages/category_navigator)
![latest commit](https://img.shields.io/github/last-commit/AnonymousAliensX/category_navigator?logo=github)

A flutter ui package for cool navigation bar with a lot of customization options

<img src="https://github.com/AnonymousAliensX/category_navigator/blob/main/demo_gifs/demo.gif?raw=true" width="250" height="480"/> <img src="https://github.com/AnonymousAliensX/category_navigator/blob/main/demo_gifs/demo3.gif?raw=true" width="250" height="480"/>

## Features

- navigation bar customization like color, elevation, shape, border radius, axis, etc
- unselected and highlighted item customization like background color, text color, shape, shadow, elevation, etc
- animate to default active item
- can use icons, or labels, or both

Check out [changelog](https://github.com/AnonymousAliensX/category_navigator/blob/main/CHANGELOG.md) for updates on features and fixes.


## Getting started

To start using this package, add `category_navigator` dependency to your `pubspec.yaml`

```yaml
dependencies:
    category_navigator: "<latest_release>"
```

## Usage
Here's a basic example to get started with the package.

```dart
final List<String> itemsList = const ['All', 'Android', 'ML', 'Python', 'Flutter', 'Text', 'iOS', 'Web', 'Windows'];

@override
Widget build(BuildContext context) {
return Scaffold(
    body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CategoryNavigator(
              items: itemsList,
              navigatorController: NavigatorController(),
              scrollController: ScrollController(),
            )
        )
    ));
}
```

To get the navigator's current position at any time, initialize an object using `NavigatorController()`, pass the controller object to `navigatorController` parameter of the constructor and then use `_navigatorController.activeItemIndex` to get the selected item's index

Take a look at [code examples](https://github.com/AnonymousAliensX/category_navigator/tree/main/example).

## CategoryNavigator parameters

`labels` and `icons` paramters both cannot be `null`, you have to provide atleast one of them.
Additional parameters include all the parameters of CategoryNavigatorItem class. See [CategoryNavigatorItem parameters](#categorynavigatoritem-parameters) for more details.

| S. No. | Parameter | Description | Default Value |
| ------ | --------- | ----------- | ------------- |
| 1 | labels | List of strings to display in the navigation menu | optional |
| 2 | icons | List of icons to display in the navigation menu | optional | 
| 2 | scrollController | An instance of the ScrollController class to handle the scrolling of navigation bar | required |
| 3 | navigatorController | An instance of the NavigatorController class to handle the active item | required |
| 4 | defaultActiveItem | Index of the default active item in the list | 0 |
| 5 | navigatorBackgroundColor | Background color of the navigation bar | Colors.black |
| 6 | margin | Margin around the navigation bar | EdgeInsets.symmetric(horizontal: 16) |
| 7 | padding | Padding inside the navigator | EdgeInsets.symmetric(horizontal: 8.0, vertical: 0) |
| 8 | axis | Axis direction of the navigation bar | Axis.horizontal |
| 9 | shape | Shape of the navigation bar | RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))) |
| 10 | navigatorElevation | Elevation of the navigator bar | 5 |

## CategoryNavigatorItem parameters

`labels` and `iconData` paramters both cannot be `null`, you have to provide atleast one of them.

| S. No. | Parameter | Description | Default Value |
| ------ | --------- | ----------- | ------------- |
| 1 | label | String to display in the navigation menu | optional |
| 2 | iconData | Icon to display in the navigation menu | optional |
| 3 | navigatorController | An instance of the NavigatorController class to handle the active item | required || 1 | highlightBackgroundColor | Background color of the highlighted item | Colors.white |
| 4 | unselectedBackgroundColor | Background color of the unselected item | Colors.black |
| 5 | highlightTextStyle | Text style for the highlighted item | TextStyle(color: Colors.black) |
| 6 | unselectedTextStyle | Text style for unselected items | TextStyle(color: Colors.white) |
| 7 | shadow | Shadows for the navigation bar | [BoxShadow(color: Colors.black)] |
| 8 | itemElevation | Elevation of the highlighted navigation item | 0 |
| 9 | borderRadius | Border radius of the navigation items | BorderRadius.all(Radius.circular(10)) |
| 10 | itemPadding | Padding for the navigation items | EdgeInsets.symmetric(horizontal: 12, vertical: 12) |
| 11 | itemMargin | Margin for the navigation items | EdgeInsets.symmetric(horizontal: 8) |




# Bugs or Requests

If you encounter any problems feel free to open an [issue](https://github.com/AnonymousAliensX/category_navigator/issues/new?template=bug_report.md). If you feel the library is missing a feature, please raise a [ticket](https://github.com/AnonymousAliensX/category_navigator/issues/new?template=feature_request.md) on GitHub and I'll look into it. Pull request are also welcome.

# License

category_navigator is licensed under `MIT license`. View [license](https://github.com/AnonymousAliensX/category_navigator/blob/main/LICENSE).
