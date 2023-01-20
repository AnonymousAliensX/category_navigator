<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Category Navigator
A flutter ui package for cool navigation bar with a lot of customization options

<img src="demo.gif" alt="drawing" width="250" height="481"/>

## Features
- navigation bar customization like color, elevation, shape, border radius, axis, etc
- unselected and highlighted item customization like background color, text color, shape, shadow, elevation, etc
- animate to default active item

## Getting started
To start using this package, add `src` dependency to your `pubspec.yaml`
```yaml
dependencies:
  src: '<latest_release>'
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

If you encounter any problems feel free to open an [issue](https://github.com/AnonymousAliensX/CachingDatabase/issues/new?template=bug_report.md). If you feel the library is missing a feature, please raise a [ticket](https://github.com/aagarwal1012/Animated-Text-Kit/issues/new?template=feature_request.md) on GitHub and I'll look into it. Pull request are also welcome.   


# License  
category_navigator is licensed under `MIT license`. View [license](LICENSE).