# Category Navigator

A flutter ui package for cool navigation bar with a lot of customization options

<img src="https://github.com/AnonymousAliensX/category_navigator/blob/main/demo_gifs/demo.gif?raw=true" width="250" height="480"/> <img src="https://github.com/AnonymousAliensX/category_navigator/blob/main/demo_gifs/demo3.gif?raw=true" width="250" height="480"/>

## Features

-   navigation bar customization like color, elevation, shape, border radius, axis, etc
-   unselected and highlighted item customization like background color, text color, shape, shadow, elevation, etc
-   animate to default active item
- added icon support

## Getting started

To start using this package, add `category_navigator` dependency to your `pubspec.yaml`

```yaml
dependencies:
    category_navigator: "<latest_release>"
```

## Usage

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

# Bugs or Requests

If you encounter any problems feel free to open an [issue](https://github.com/AnonymousAliensX/category_navigator/issues/new?template=bug_report.md). If you feel the library is missing a feature, please raise a [ticket](https://github.com/AnonymousAliensX/category_navigator/issues/new?template=feature_request.md) on GitHub and I'll look into it. Pull request are also welcome.

# License

category_navigator is licensed under `MIT license`. View [license](https://github.com/AnonymousAliensX/category_navigator/blob/main/LICENSE).
