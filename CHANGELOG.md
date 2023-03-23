## 1.0.0 - 20/01/2023

* Initial release

## 1.0.1 - 20/01/2023

* Minor changes

## 1.1.0 - 27/01/2023

* Added support for icons in addition to labels

## 1.1.1 - 28/01/2023

* Height issue fixed:
  Read [commit](https://github.com/AnonymousAliensX/category_navigator/commit/2920f9cd5de3cdd03bd38fae2fe8851f6d1ed0b5)
  description for detailed explanation of the issue

## 1.1.2 - 31/01/2023

* Only icons support added: Before the navigator would have worked if only labels were passed, or if
  labels and icons both were passed, but it wouldn't have worked with icons only. Now it will work
  even if only icons are passed.

## 1.1.3 - 02/02/2023

* Issue where 'borderRadius' parameter was not having effect on the item fixed
* Documentation added
* Minor changes

## 1.1.4 - 02/02/2023

* added examples

## 1.1.5 - 23/03/2023

* removed vertical navigator (will be added back in future release)
* fixed a scroll issue
* added iconSize attribute
* added onChange callback functionality, now there's no need to manually listen to
  NavigatorController for updates

## 1.1.6 - 23/03/2023

* update active item after build