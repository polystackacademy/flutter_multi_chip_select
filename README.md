# flutter_multi_chip_select

[![License][license-image]][license-url] 

A simple and versatile multiple chip select component for App developers, with different style.🚀

## Getting Started

```yaml
dependencies:
 flutter_multi_chip_select: ^0.1.0
```

## Features

- [x] Created base library structure.
- [ ] Add support to multiple select layouts.
- [ ] Implement custom styling of components.
- [ ] Light/Dark Theme  support.

## Usage example

### Bottom Popup with no filters
<img src="https://github.com/thepolyglots/resources/blob/master/packages/multiple_chip_select/simple_select.gif?raw=true" width="150px">

```dart
final multiSelectKey = GlobalKey<MultiSelectDropdownState>();
var menuItems = [1, 2, 3, 4, 5, 6];

FlutterMultiChipSelect(
      key: multiSelectKey,
      elements: List.generate(
        menuItems.length,
        (index) => MultiSelectItem<String>.simple(
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    menuItems.remove(menuItems[index]);
                  });
                  print("Delete Call at: " + menuItems[index].toString());
                },
              )
            ],
            title: "Item " + menuItems[index].toString(),
            value: menuItems[index].toString()),
      ),
      label: "Dropdown Select",
      values: [
        1, 2 // Pass Initial value array or leave empty array.
      ],
    )
```

## Contribute

Any contribution is deeply appreciated.

## License

Distributed under the MIT license. See ``LICENSE`` for more information.

## About

- Abhinav Jha - Initial work - [Portfolio](https://github.com/abhinav2127)

[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
