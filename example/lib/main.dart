import 'package:flutter/material.dart';
import 'package:flutter_multi_chip_select/flutter_multi_chip_select.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final multiSelectKey = GlobalKey<MultiSelectDropdownState>();
  String _result = "";
  var menuItems = [1, 2, 3, 4, 5, 6];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlutterMultiChipSelect(
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
                      values: [],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      setState(() {
                        _result =
                            this.multiSelectKey.currentState.result.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
            Text((_result != "") ? "Save Result" + _result : "")
          ],
        ),
      ),
    );
  }
}
