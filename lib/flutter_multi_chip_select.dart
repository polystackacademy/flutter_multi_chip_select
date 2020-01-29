import 'package:flutter/material.dart';

class MultiSelectItem<T> {
  T value;
  Widget child;
  List<Widget> leading = [];
  bool disabled = false;
  // select default action is added by default
  List<Widget> actions = [];
  bool isSelected = false;

  MultiSelectItem.custom(
      {@required this.child,
      @required this.value,
      this.leading,
      this.actions,
      this.disabled = false});

  MultiSelectItem.simple(
      {@required String title,
      @required this.value,
      List<Widget> actions,
      this.disabled = false}) {
    this.child = Text(title);
    this.actions = actions;
  }
}

class FlutterMultiChipSelect extends StatefulWidget {
  final String label;
  final List<MultiSelectItem> elements;
  final List values;
  final bool disabled;

  const FlutterMultiChipSelect({
    Key key,
    @required this.label,
    @required this.elements,
    @required this.values,
    this.disabled = false,
  })  : assert(values != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => MultiSelectDropdownState();
}

class MultiSelectDropdownState extends State<FlutterMultiChipSelect> {
  // this will return the selected value. Please use key to fetch from current state.
  List _result = [];
  List get result => this._result;

  Widget _getContent() {
    if (this._result.length <= 0 && this.widget.label != null) {
      return Padding(
        child: Text(
          this.widget.label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            decoration: TextDecoration.none,
          ),
        ),
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: this
              .widget
              .elements
              .where((element) => this._result.contains(element.value))
              .map((element) {
            element.isSelected = true;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: RawChip(
                isEnabled: !this.widget.disabled,
                label: element.child,
                onDeleted: () {
                  if (!this.widget.disabled) {
                    setState(() {
                      element.isSelected = false;
                      this._result.remove(element.value);
                    });
                  }
                },
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (this.widget.values != null) this._result = this.widget.values;
  }

  void _showMultipleSelectDialog() async {
    var result = await showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) => SelectListModal(
        label: this.widget.label,
        elements: this.widget.elements,
        values: this._result,
      ),
    );
    setState(() {
      if (result != null) {
        this._result = result ?? this._result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Opacity(
              opacity: this.widget.disabled ? 0.4 : 1,
              child: Container(
                margin: EdgeInsets.only(right: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: this._getContent(),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 5.5),
                      child: Icon(Icons.list, color: Colors.black54),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 0.5, color: Colors.grey[350]))),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        if (!this.widget.disabled) _showMultipleSelectDialog();
      },
    );
  }
}

class SelectListModal extends StatefulWidget {
  final String label;
  final List<MultiSelectItem> elements;
  final List values;

  const SelectListModal(
      {Key key,
      @required this.label,
      @required this.elements,
      @required this.values})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => SelectListModalState();
}

class SelectListModalState extends State<SelectListModal> {
  List _result = [];
  List get result => this._result;

  @override
  void initState() {
    super.initState();
    if (this.widget.values != null) _result = this.widget.values;
  }

  List<Widget> _buildItemRow(MultiSelectItem item) {
    List<Widget> widgets = new List<Widget>();
    widgets.addAll(item.leading ?? []);
    widgets.add(Expanded(child: item.child));
    widgets.add(item.isSelected
        ? Icon(
            Icons.radio_button_checked,
            color: Colors.black54,
            size: 30,
          )
        : Icon(
            Icons.add,
            color: Colors.grey,
            size: 30,
          ));
    widgets.addAll(item.actions ?? []);
    return widgets;
  }

  var getToolbar = (context, values) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        height: 40,
        child: GestureDetector(
          onTap: () => Navigator.pop(context, values),
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(width: 2, color: Colors.grey[350])),
              color: Colors.grey[200],
            ),
            child: Container(
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 35,
              ),
            ),
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 30,
                  child: Text(
                    this.widget.label,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 1.0, color: Colors.black54),
                  itemCount: this.widget.elements.length,
                  itemBuilder: (context, index) {
                    MultiSelectItem item = this.widget.elements[index];
                    return GestureDetector(
                      onTap: () {
                        this._result.contains(item.value)
                            ? this._result.remove(item.value)
                            : this._result.add(item.value);
                        setState(() {
                          item.isSelected = this._result.contains(item.value);
                        });
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildItemRow(item),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: Colors.black54, blurRadius: 5.0),
              ]),
          padding: EdgeInsets.only(top: 20, bottom: 5, left: 6, right: 6),
          // margin: EdgeInsets.only(top: this.widget.height, bottom: 40),
        ),
        this.getToolbar(context, this._result),
      ],
    );
  }
}
